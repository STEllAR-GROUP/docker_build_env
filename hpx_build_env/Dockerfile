# Copyright (c) 2020 Mikael Simberg
# Copyright (c) 2015 Martin Stumpf
# Copyright (c) 2025-2026 Hartmut Kaiser
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

FROM ubuntu:jammy

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
    echo "deb-src http://archive.ubuntu.com/ubuntu jammy main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu jammy-updates main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu jammy universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu jammy-updates universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu jammy multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu jammy-updates multiverse" >> /etc/apt/sources.list && \
    echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy main" >> /etc/apt/sources.list && \
    echo "deb-src http://apt.llvm.org/jammy/ llvm-toolchain-jammy main" >> /etc/apt/sources.list && \
    echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-22 main" >> /etc/apt/sources.list && \
    echo "deb-src http://apt.llvm.org/jammy/ llvm-toolchain-jammy-22 main" >> /etc/apt/sources.list && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y            \
                    jq                              \
                    kmod                            \
                    binutils                        \
                    clang-22                        \
                    clang-tools-22                  \
                    clang-22-doc                    \
                    libclang-common-22-dev          \
                    libclang-22-dev                 \
                    libclang1-22                    \
                    clang-format-22                 \
                    clangd-22                       \
                    clang-tidy-22                   \
                    libc++-22                       \
                    libc++-22-dev                   \
                    libc++abi-22-dev                \
                    libllvm-22-ocaml-dev            \
                    llvm-22                         \
                    llvm-22-dev                     \
                    llvm-22-doc                     \
                    llvm-22-examples                \
                    llvm-22-runtime                 \
                    liblldb-22-dev                  \
                    libomp-22-dev                   \
                    libomp5-22                      \
                    lld-22                          \
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
                    python3.10-venv

#                    libunwind-dev
#                    libgoogle-perftools-dev

# Get cmake files (in separate RUN command to get cached)
RUN wget -q https://cmake.org/files/v4.3/cmake-4.3.2-linux-x86_64.tar.gz -O cmake.tar.gz && \
    echo "791ae3604841ca03cb3889a3ad89165346e4b180ae3448efd4b0caa9ef46d245  cmake.tar.gz" | sha256sum --check --status && \
    tar --strip-components=1 -C /usr/local -xf cmake.tar.gz && \
    rm cmake.tar.gz

RUN wget -q https://github.com/mozilla/grcov/releases/download/v0.7.1/grcov-linux-x86_64.tar.bz2 -O grcov.tar.bz2 && \
    echo "603196293bed54d7ec6fb6d6f85db27966c4512235c7bd6555e1082e765c5bd2 grcov.tar.bz2" | sha256sum --check --status && \
    tar -jxf grcov.tar.bz2 && \
    mv grcov /usr/bin && \
    rm grcov.tar.bz2

ENV CC=clang-22
ENV CXX=clang++-22

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
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/ninja-build/ninja.git && \
    cd ninja && git checkout -b v1.13.1 && ./configure.py --bootstrap && cp ninja /usr/local/bin/ && \
    cd /tmp && rm -rf ninja/


RUN add-apt-repository ppa:ubuntu-toolchain-r/test

RUN apt-get update && apt-get install -y gcc-12 g++-12                   

# IMPORTANT: Did you read the note at the top of the file?
