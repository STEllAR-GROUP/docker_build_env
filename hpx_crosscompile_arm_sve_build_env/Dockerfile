# Copyright (c) 2022 Srinivas Yadav
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM ubuntu:jammy

ENV LD_LIBRARY_PATH /usr/aarch64-linux-gnu/lib64:/usr/aarch64-linux-gnu/lib:/usr/arm-linux-gnueabihf/lib:/usr/powerpc64le-linux-gnu/lib/
ENV DEBIAN_FRONTEND noninteractive
ENV BOOST_URL       https://boostorg.jfrog.io/artifactory/main/release/1.80.0/source/boost_1_80_0.tar.gz
ENV HWLOC_URL       https://download.open-mpi.org/release/hwloc/v2.7/hwloc-2.7.1.tar.gz

RUN   apt-get update -y && apt-get install -y --no-install-recommends gpg-agent debian-keyring              \
      software-properties-common apt-utils                                                            &&    \
      add-apt-repository ppa:ubuntu-toolchain-r/test                                                  &&    \
      apt-get update -y                                                                               &&    \
      apt-get -y install sudo tzdata openssh-server curl wget libssl-dev libffi-dev ca-certificates   &&    \
      wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -                         &&    \
      add-apt-repository deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-14 main                  &&    \
      apt-get update -y

RUN   apt-get install -y --no-install-recommends                                                            \
      less unzip tar gzip                                                                                   \
      python3 python3-defusedxml python3-lxml                                                               \
      build-essential ninja-build cmake git                                                                 \
      valgrind  jq  gdb                                                                                     \
      nano vim pkg-config

RUN   apt-get install -y --no-install-recommends                                                            \
      qemu qemu-user qemu-user-binfmt libc6-arm64-cross

RUN   apt-get install -y --no-install-recommends                                                            \
      g++-11 gcc-11-multilib g++-11-multilib                                                                \
      g++-11-aarch64-linux-gnu g++-11-arm-linux-gnueabihf                                                   \
      g++-11-powerpc64-linux-gnu                                                                            \
      g++-11-powerpc64le-linux-gnu  g++-11-powerpc-linux-gnu                                                \
      binutils-aarch64-linux-gnu                                                                            \
      binutils-powerpc64-linux-gnu

RUN   apt-get install -y --no-install-recommends                                                            \
      libc++-14-dev libc++abi-14-dev clang clang-format lld

RUN   ln -sf /usr/aarch64-linux-gnu/lib/ld-linux-aarch64.so.1     /lib/ld-linux-aarch64.so.1          &&    \
      ln -sf /usr/arm-linux-gnueabihf/lib/ld-linux-armhf.so.3     /lib/ld-linux-armhf.so.3            &&    \
      ln -sf /usr/powerpc64le-linux-gnu/lib64/ld64.so.2           /lib64/ld64.so.2                    &&    \
      ln -sf /usr/powerpc64-linux-gnu/lib64/ld64.so.1             /lib64/ld64.so.1

ENV CC aarch64-linux-gnu-gcc-11
ENV CXX aarch64-linux-gnu-g++-11

RUN   mkdir /opt/download /opt/build /opt/install 
RUN   cd /opt/download && wget ${BOOST_URL} && wget ${HWLOC_URL}

RUN   mkdir /opt/install/boost /opt/install/boost/debug mkdir /opt/install/boost/release
RUN   cd /opt/build && tar -xf /opt/download/boost_1_80_0.tar.gz && \
      cd boost_1_80_0 && \
      echo "using gcc : arm : aarch64-linux-gnu-g++-11 ;" > user_config.jam                           &&    \
      ./bootstrap.sh --prefix=/opt/install/boost/release/boost                                        &&    \
      ./b2 install toolset=gcc-arm architecture=arm address-model=64 abi=aapcs                              \
            binary-format=elf --without-python -s NO_BZIP2=1 threading=multi                                \
            link=shared variant=release --prefix=/opt/install/boost/release/boost                           \
            --user-config=user_config.jam                                                             &&    \
      cd .. && rm -rf boost_1_80_0

RUN   cd /opt/build && tar -xf /opt/download/boost_1_80_0.tar.gz &&                                         \
      cd boost_1_80_0 &&                                                                                    \
      echo "using gcc : arm : aarch64-linux-gnu-g++-11 ;" > user_config.jam                           &&    \
      ./bootstrap.sh --prefix=/opt/install/boost/debug/boost                                          &&    \
      ./b2 install toolset=gcc-arm architecture=arm address-model=64 abi=aapcs                              \
            binary-format=elf --without-python -s NO_BZIP2=1 threading=multi                                \
            link=shared variant=debug --prefix=/opt/install/boost/debug/boost                               \
            --user-config=user_config.jam

RUN   cd /opt/build                                                                                   &&    \
      tar -xf /opt/download/hwloc-2.7.1.tar.gz  && cd hwloc-2.7.1                                     &&    \
      ./configure --prefix=/opt/install/hwloc --host=aarch64-linux                                    &&    \
      make && make install

RUN   cd /opt/download && git clone https://github.com/srinivasyadav18/sve.git

RUN   mkdir /opt/install/sve /opt/install/sve/debug /opt/install/sve/release

RUN   cmake -S /opt/download/sve -B /opt/build/sve_debug                                                    \
            -DCMAKE_INSTALL_PREFIX=/opt/install/sve/debug/sve                                               \
            -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_FLAGS=-march=armv8-a+sve                                   \
            -DSVE_LENGTH=512 -DCMAKE_CROSSCOMPILING_CMD=qemu-aarch64

RUN   cmake  --build /opt/build/sve_debug && cmake --install /opt/build/sve_debug

RUN   cmake -S /opt/download/sve -B /opt/build/sve_release                                                  \
            -DCMAKE_INSTALL_PREFIX=/opt/install/sve/release/sve                                             \
            -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-march=armv8-a+sve                                 \
            -DSVE_LENGTH=512 -DCMAKE_CROSSCOMPILING_CMD=qemu-aarch64

RUN   cmake  --build /opt/build/sve_release && cmake --install /opt/build/sve_release

RUN  rm -rf /var/lib/apt/lists/*
RUN  rm -rf /opt/build /opt/download
