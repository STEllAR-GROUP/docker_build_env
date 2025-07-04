# Copyright (c) 2020 Mikael Simberg
# Copyright (c) 2015 Martin Stumpf
# Copyright (c) 2025 Hartmut Kaiser
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# The images built from this Dockerfile are versioned with an incrementing
# number in .circleci/config.yml. The version is set in the environment variable
# IMAGE_NAME_VERSIONED.
#
# IMPORTANT: Unless you are 100% sure that the changes to this file will produce
# an image that is compatible with the previous image please increment the
# version!  Incrementing the version means that the image used for e.g. HPX CI
# can be updated and tested in a separate PR without risking breaking open pull
# request builds.

FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

# Update and install libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
                    apt-utils apt-transport-https   \
                    software-properties-common      \
                    wget gnupg2 gpg curl zip        \
                    ca-certificates &&              \
    wget https://apt.llvm.org/llvm-snapshot.gpg.key --no-check-certificate && \
    apt-key add llvm-snapshot.gpg.key &&            \
    apt update &&                                   \
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

RUN apt-get update && apt-get install -y            \
                    jq                              \
                    kmod                            \
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
                    libc++-20                       \
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
                    libasio-dev                     \
                    libhwloc-dev                    \
                    libltdl-dev                     \
                    libudev-dev                     \
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
                    vc-dev                          \
                    doxygen                         \
                    python3                         \
                    python3-pip                     \
                    texlive                         \
                    texlive-latex-extra             \
                    latexmk                         \
                    tex-gyre                        \
                    libjson-perl                    \
                    ninja-build                     \
                    codespell                       \
                    git                             \
                    xsltproc                        \
                    rpm                             \
                    sudo                            \
                    pkg-config                      \
                    graphviz                        \
                    iwyu                            \
                    devscripts                      \
                    zlib1g-dev                      \
                    wget                            \
                    python3.8-venv

#                    libunwind-dev
#                    libgoogle-perftools-dev

# Get cmake files (in separate RUN command to get cached)
RUN wget -q https://cmake.org/files/v3.31/cmake-3.31.8-linux-x86_64.tar.gz -O cmake.tar.gz && \
    echo "630615d8e98ac33eba7fbe472626dff5c899c85af3c024585ae109166a6909d0  cmake.tar.gz" | sha256sum --check --status && \
    tar --strip-components=1 -C /usr/local -xf cmake.tar.gz && \
    rm cmake.tar.gz

RUN wget -q https://github.com/mozilla/grcov/releases/download/v0.7.1/grcov-linux-x86_64.tar.bz2 -O grcov.tar.bz2 && \
    echo "603196293bed54d7ec6fb6d6f85db27966c4512235c7bd6555e1082e765c5bd2 grcov.tar.bz2" | sha256sum --check --status && \
    tar -jxf grcov.tar.bz2 && \
    mv grcov /usr/bin && \
    rm grcov.tar.bz2

ENV CC=clang-20
ENV CXX=clang++-20

COPY docs_requirements.txt docs_requirements.txt


# Creating a python env to eliminate conflicts with system python packages
ENV PYTHON_VENV=/opt/venv
RUN python3 -m venv $PYTHON_VENV
ENV PATH="$PYTHON_VENV/bin:$PATH"

#    rm /usr/bin/ld && ln -s /usr/bin/ld.lld /usr/bin/ld && 

RUN pip3 install --upgrade pip && pip3 install -r docs_requirements.txt cmake_format && \
    cd /tmp && \
    git clone https://github.com/tomtom-international/cpp-dependencies.git && \
    cd cpp-dependencies && cmake . && make -j install && \
    cd /tmp && rm -rf /tmp/cpp-dependencies && \
    git clone --single-branch --branch 1.4.1 https://github.com/VcDevel/Vc.git && \
    cd Vc && git submodule update --init && \
    mkdir -p build && cd build && \
    cmake -DBUILD_TESTING=OFF .. && make -j install && \
    cd /tmp && rm -rf Vc && \
    rm -rf /var/lib/apt/lists/*

# IMPORTANT: Did you read the note at the top of the file?
