# Copyright (c) 2020 Mikael Simberg
# Copyright (c) 2015 Martin Stumpf
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

# Update and install libraries
RUN apt-get update -qq && apt-get install -y -qq --no-install-recommends curl gnupg && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates multiverse" >> /etc/apt/sources.list && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -y -qq    \
                    apt-utils &&                    \
                    apt-get install -qq             \
                    --no-install-recommends -y      \
                    wget zip curl ca-certificates   \
                    clang                           \
                    clang-format-9                  \
                    clang-tidy                      \
                    jq                              \
                    kmod                            \
                    llvm                            \
                    lld                             \
                    llvm-dev                        \
                    libclang-dev                    \
                    libhwloc-dev                    \
                    libjemalloc-dev                 \
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
                    iwyu                            \
                    devscripts                      \
                    wget

# Get cmake files (in separate RUN command to get cached)
RUN wget -q https://cmake.org/files/v3.17/cmake-3.17.5-Linux-x86_64.tar.gz -O cmake.tar.gz && \
    echo "897142368b15a5693c999a7ed2187be20c1b41a68c3711379d32a33469bb29ba cmake.tar.gz" | sha256sum --check --status && \
    tar --strip-components=1 -C /usr/local -xf cmake.tar.gz && \
    rm cmake.tar.gz

RUN wget -q https://github.com/mozilla/grcov/releases/download/v0.7.1/grcov-linux-x86_64.tar.bz2 -O grcov.tar.bz2 && \
    echo "603196293bed54d7ec6fb6d6f85db27966c4512235c7bd6555e1082e765c5bd2 grcov.tar.bz2" | sha256sum --check --status && \
    tar -jxf grcov.tar.bz2 && \
    mv grcov /usr/bin && \
    rm grcov.tar.bz2

# NOTE: breathe is pinned to 4.16.0 as 4.17.0 introduced a regression in
# handling "friend struct x;", see
# https://github.com/michaeljones/breathe/issues/521. The pinned version can be
# removed when the issue has been resolved.
RUN pip3 install sphinx sphinx-rtd-theme breathe==4.16.0 cmake_format && \
    rm /usr/bin/ld && ln -s /usr/bin/ld.lld /usr/bin/ld && cd /tmp && \
    git clone https://github.com/tomtom-international/cpp-dependencies.git && \
    cd cpp-dependencies && cmake . && make -j install && \
    cd /tmp && rm -rf /tmp/cpp-dependencies &&      \
    git clone --single-branch --branch clang_10 https://github.com/include-what-you-use/include-what-you-use.git && \
    mkdir -p include-what-you-use/build && cd include-what-you-use/build && \
    cmake -DCMAKE_PREFIX_PATH="/usr/lib/llvm-10" -DCMAKE_INSTALL_PREFIX="/usr" .. && make -j install && \
    cd /tmp && rm -rf include-what-you-use &&       \
    rm -rf /var/lib/apt/lists/*

ENV CC clang
ENV CXX clang++
