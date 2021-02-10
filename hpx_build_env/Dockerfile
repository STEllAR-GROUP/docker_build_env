# Copyright (c) 2020 Mikael Simberg
# Copyright (c) 2015 Martin Stumpf
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM ubuntu:focal

# Update and install libraries
RUN apt-get update && apt-get install -y --no-install-recommends curl gnupg && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates multiverse" >> /etc/apt/sources.list && \
    rm -rf /var/lib/apt/lists/*

# NOTE: breathe is pinned to 4.16.0 as 4.17.0 introduced a regression in
# handling "friend struct x;", see
# https://github.com/michaeljones/breathe/issues/521. The pinned version can be
# removed when the issue has been resolved.
RUN export DEBIAN_FRONTEND=noninteractive &&        \
    apt-get update && apt-get install -y            \
                    apt-utils &&                    \
                    apt-get install                 \
                    --no-install-recommends -y      \
                    clang                           \
                    clang-format-9                  \
                    clang-tidy                      \
                    lcov                            \
                    llvm                            \
                    lld                             \
                    llvm-dev                        \
                    libclang-dev                    \
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
                    iwyu                            \
                    devscripts &&                   \
    pip3 install sphinx sphinx-rtd-theme breathe==4.16.0 cmake_format && \
    rm /usr/bin/ld && ln -s /usr/bin/ld.lld /usr/bin/ld && \
    cd /tmp &&                                      \
    git clone https://github.com/tomtom-international/cpp-dependencies.git && \
    cd cpp-dependencies && cmake . && make -j install && \
    cd /tmp && rm -rf /tmp/cpp-dependencies &&      \
    git clone --single-branch --branch clang_10 https://github.com/include-what-you-use/include-what-you-use.git && \
    mkdir -p include-what-you-use/build && cd include-what-you-use/build && \
    cmake -DCMAKE_PREFIX_PATH="/usr/lib/llvm-10" -DCMAKE_INSTALL_PREFIX="/usr" .. && make -j install && \
    cd /tmp && rm -rf include-what-you-use &&       \
    rm -rf /var/lib/apt/lists/*

ARG LCOV_WRAPPER=/usr/local/bin/llvm-cov-wrapper

RUN echo '#!/bin/bash' >> ${LCOV_WRAPPER} && \
    echo 'llvm-cov gcov "$@"' >> ${LCOV_WRAPPER} && \
    chmod +x ${LCOV_WRAPPER}

ENV CC clang
ENV CXX clang++
