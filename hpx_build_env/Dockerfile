# Copyright (c) 2015 Martin Stumpf
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM ubuntu:bionic

# Update and install libraries
RUN apt-get update && apt-get install -y curl gnupg && \
    echo "deb-src http://archive.ubuntu.com/ubuntu bionic main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu bionic-updates main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu bionic universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu bionic-updates universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu bionic multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu bionic-updates multiverse" >> /etc/apt/sources.list && \
    echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main" >> /etc/apt/sources.list && \
    echo "deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main" >> /etc/apt/sources.list && \
    curl https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

RUN export DEBIAN_FRONTEND=noninteractive &&        \
    apt-get update && apt-get install -y            \
                    clang-7                         \
                    clang-7-doc                     \
                    libclang-common-7-dev           \
                    libclang-7-dev                  \
                    libclang1-7                     \
                    libllvm7                        \
                    llvm-7                          \
                    llvm-7-dev                      \
                    llvm-7-runtime                  \
                    clang-format-7                  \
                    clang-tidy-7                    \
                    lld-7                           \
                    libhwloc-dev                    \
                    libjemalloc-dev                 \
                    cmake                           \
                    libboost-atomic-dev             \
                    libboost-chrono-dev             \
                    libboost-date-time-dev          \
                    libboost-filesystem-dev         \
                    libboost-iostreams-dev          \
                    libboost-program-options-dev    \
                    libboost-regex-dev              \
                    libboost-system-dev             \
                    libboost-thread-dev             \
                    mpi-default-dev                 \
                    doxygen                         \
                    python3                         \
                    python3-pip                     \
                    texlive                         \
                    texlive-latex-extra             \
                    latexmk                         \
                    libjson-perl                    \
                    ninja-build                     \
                    git                             \
                    xsltproc                        \
                    rpm                             \
                    pkg-config                      \
                    devscripts &&                   \
    pip3 install sphinx sphinx-rtd-theme breathe && \
    apt-get -y build-dep openmpi && cd /tmp &&      \
    apt-get source openmpi && cd openmpi-* &&       \
    sed -i '/enable-heterogeneous/d' debian/rules && \
    sed -i '/(NO_JAVA_ARCH)/I,+4 d' debian/rules && \
    debuild -uc -us -b && debi &&                   \
    cd .. && rm -rf openmpi* &&                     \
    update-alternatives --install /usr/bin/clang++  \
        clang++ /usr/bin/clang++-7 100 &&           \
    update-alternatives --install /usr/bin/clang    \
        clang /usr/bin/clang-7 100 &&               \
    update-alternatives --install /usr/bin/clang-tidy \
        clang-tidy /usr/bin/clang-tidy-7 100 &&     \
    rm /usr/bin/ld && ln -s /usr/bin/ld.lld-7 /usr/bin/ld

# Install cpp-dependencies tool to check for circular includes
RUN git clone https://github.com/tomtom-international/cpp-dependencies.git /hpx/tools/cpp-dependencies && \
    cd /hpx/tools/cpp-dependencies && cmake . && make -j && cd /

ENV PATH="${PATH}:/hpx/tools/cpp-dependencies/src"
ENV CC clang
ENV CXX clang++
