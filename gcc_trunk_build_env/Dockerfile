# Copyright (c) 2026 Surya Teja
# Copyright (c) 2026 Hartmut Kaiser
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

# building gcc trunk
FROM ubuntu:24.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    cmake \
    ninja-build \
    python3 \
    wget \
    ca-certificates \
    flex \
    bison \
    texinfo \
    libgmp-dev \
    libmpfr-dev \
    libmpc-dev \
    libisl-dev \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 --branch=trunk https://gcc.gnu.org/git/gcc.git /src/gcc
WORKDIR /src/gcc
RUN ./contrib/download_prerequisites
RUN mkdir /build && cd /build && \
    /src/gcc/configure \
        --prefix=/gcc \
        --enable-languages=c,c++ \
        --disable-multilib \
        --enable-checking=release \
        --enable-host-shared
RUN make -C /build -j$(nproc)
RUN make -C /build install

# runtime image
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ninja-build \
    git \
    curl \
    wget \
    python3 \
    python3-dev \
    sudo \
    ca-certificates \
    vim \
    libhwloc-dev \
    libboost-dev \
 && rm -rf /var/lib/apt/lists/*
 
# modern cmake for cxx26
RUN wget https://github.com/Kitware/CMake/releases/download/v3.30.5/cmake-3.30.5-linux-x86_64.sh \
 && chmod +x cmake-3.30.5-linux-x86_64.sh \
 && ./cmake-3.30.5-linux-x86_64.sh --skip-license --prefix=/usr/local \
 && rm cmake-3.30.5-linux-x86_64.sh

COPY --from=builder /gcc /usr/local
RUN echo "/usr/local/lib64" > /etc/ld.so.conf.d/gcc.conf \
 && echo "/usr/local/lib" >> /etc/ld.so.conf.d/gcc.conf \
 && ldconfig

WORKDIR /workspace

# IMPORTANT: Did you read the note at the top of the file?
