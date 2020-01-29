# Copyright (c) 2020 Mikael Simberg
# Copyright (c) 2015 Martin Stumpf
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM ubuntu:focal

# Update and install libraries
RUN apt-get update && apt-get install -y curl gnupg && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates multiverse" >> /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive &&        \
    apt-get update && apt-get install -y            \
                    clang                           \
                    clang-format                    \
                    clang-tidy                      \
                    lld                             \
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
                    codespell                       \
                    git                             \
                    xsltproc                        \
                    rpm                             \
                    pkg-config                      \
                    graphviz                        \
                    devscripts &&                   \
    pip3 install sphinx sphinx-rtd-theme breathe && \
    rm /usr/bin/ld && ln -s /usr/bin/ld.lld-9 /usr/bin/ld && \
    apt-get -y build-dep openmpi && cd /tmp &&      \
    apt-get source openmpi && cd openmpi-* &&       \
    sed -i '/enable-heterogeneous/d' debian/rules && \
    sed -i '/(NO_JAVA_ARCH)/I,+4 d' debian/rules && \
    debuild -uc -us -b && debi &&                   \
    cd .. && rm -rf openmpi* &&                     \
    git clone https://github.com/tomtom-international/cpp-dependencies.git /hpx/tools/cpp-dependencies && \
    cd /hpx/tools/cpp-dependencies && cmake . && make -j install

ENV CC clang
ENV CXX clang++
