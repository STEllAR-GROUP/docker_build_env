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

# stage 1: building clang-p2996
FROM ubuntu:24.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ninja-build \
    git \
    cmake \
    python3 \
    zlib1g-dev \
    wget \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 --branch p2996 \
    https://github.com/bloomberg/clang-p2996.git \
    /src

RUN cmake -S /src/llvm -B /build \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_ENABLE_PROJECTS="clang" \
    -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
    -DCLANG_DEFAULT_CXX_STDLIB=libc++

RUN cmake --build /build -j10

RUN cmake --install /build --prefix /clang

# stage 2: runtime image
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

# installing modern CMake (needed for C++26)
RUN wget https://github.com/Kitware/CMake/releases/download/v3.30.5/cmake-3.30.5-linux-x86_64.sh \
 && chmod +x cmake-3.30.5-linux-x86_64.sh \
 && ./cmake-3.30.5-linux-x86_64.sh --skip-license --prefix=/usr/local \
 && rm cmake-3.30.5-linux-x86_64.sh

COPY --from=builder /clang /usr/local

RUN TARGET=$(clang++ -v 2>&1 | grep Target | awk '{print $2}') \
 && echo "/usr/local/lib/$TARGET" > /etc/ld.so.conf.d/clang.conf \
 && ldconfig

WORKDIR /workspace

# IMPORTANT: Did you read the note at the top of the file?
