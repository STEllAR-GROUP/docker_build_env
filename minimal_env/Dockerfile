# Copyright (c) 2020 Mikael Simberg
# Copyright (c) 2015 Martin Stumpf
# Copyright (c) 2023-2025 Hartmut Kaiser
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# The images built from this Dockerfile are versioned with an incrementing
# number in .circleci/config.yml. The version is set in the environment variable
# IMAGE_NAME_VERSIONED.
#
# IMPORTANT: Unless you are 100% sure that the changes to this file will produce
# an image that is compatible with the previous image please increment the
# version!  Incrementing the version means that the image used for e.g. ChplX CI
# can be updated and tested in a separate PR without risking breaking open pull
# request builds.

FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

# Update and install libraries
RUN apt-get update -qq && apt-get install -y -qq --no-install-recommends \
                    wget gnupg2 curl ca-certificates && \
    wget https://apt.llvm.org/llvm-snapshot.gpg.key --no-check-certificate && \
    apt-key add llvm-snapshot.gpg.key && \
    apt update && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates multiverse" >> /etc/apt/sources.list && \
    echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal main" >> /etc/apt/sources.list && \
    echo "deb-src http://apt.llvm.org/focal/ llvm-toolchain-focal main" >> /etc/apt/sources.list && \
    echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-20 main" >> /etc/apt/sources.list && \
    echo "deb-src http://apt.llvm.org/focal/ llvm-toolchain-focal-20 main" >> /etc/apt/sources.list && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -y -qq    \
                    apt-utils &&                    \
    apt-get install -qq --no-install-recommends -y  \
                    binutils                        \
                    clang-20                        \
                    clang-tools-20                  \
                    clang-20-doc                    \
                    libclang-common-20-dev          \
                    libclang-20-dev                 \
                    libclang1-20                    \
                    clang-format-20                 \
                    clangd-20                       \
                    clang-tidy-20                   \
                    libc++-20-dev                   \
                    libc++abi-20-dev                \
                    libllvm-20-ocaml-dev            \
                    llvm-20                         \
                    llvm-20-dev                     \
                    llvm-20-doc                     \
                    llvm-20-examples                \
                    llvm-20-runtime                 \
                    liblldb-20-dev                  \
                    libomp-20-dev                   \
                    libomp5-20                      \
                    lld-20                          \
                    zip curl                        \
                    jq                              \
                    kmod                            \
                    libasio-dev                     \
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
                    vc-dev                          \
                    ninja-build                     \
                    git                             \
                    pkg-config                      \
                    devscripts                      \
                    zlib1g-dev

# Get cmake files (in separate RUN command to get cached)
RUN wget -q https://cmake.org/files/v3.26/cmake-3.26.0-linux-x86_64.tar.gz -O cmake.tar.gz && \
    echo "69b55523145b2e619f637e7766c413cb1b7de1f06269ea1eab4a655d59847d59  cmake.tar.gz" | sha256sum --check --status && \
    tar --strip-components=1 -C /usr/local -xf cmake.tar.gz && \
    rm cmake.tar.gz

ENV CC=clang-20
ENV CXX=clang++-20

# IMPORTANT: Did you read the note at the top of the file?
