# Copyright (c) 2020 ETH Zurich
# Copyright (c) 2025 Hartmut Kaiser
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -y -qq --no-install-recommends \
                    wget gnupg2 curl ca-certificates

RUN mkdir --parents --mode=0755 /etc/apt/keyrings
RUN wget https://repo.radeon.com/rocm/rocm.gpg.key -O - | \
    gpg --dearmor | tee /etc/apt/keyrings/rocm.gpg > /dev/null

RUN echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/rocm/apt/6.4.2 noble main" \
    | tee /etc/apt/sources.list.d/rocm.list
RUN echo 'Package: *' > /etc/apt/preferences.d/rocm-pin-600 && \
    echo 'Pin: release o=repo.radeon.com' >> /etc/apt/preferences.d/rocm-pin-600 && \
    echo 'Pin-Priority: 600' >> /etc/apt/preferences.d/rocm-pin-600

# Install ROCm
RUN apt-get update -qq && apt-get install -y \
    rocm-language-runtime \
    rocm-hip-runtime \
    rocm-developer-tools \
    rocm-hip-sdk

# Get cmake files (in separate RUN command to get cached)
RUN wget -q https://cmake.org/files/v3.31/cmake-3.31.8-linux-x86_64.tar.gz -O cmake.tar.gz && \
    echo "630615d8e98ac33eba7fbe472626dff5c899c85af3c024585ae109166a6909d0  cmake.tar.gz" | sha256sum --check --status && \
    tar --strip-components=1 -C /usr/local -xf cmake.tar.gz && \
    rm cmake.tar.gz

RUN apt-get update && apt-get install -y            \
                    binutils                        \
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
                    ninja-build                     \
                    git                             \
                    sudo                            \
                    pkg-config                      \
                    zlib1g-dev                      \
                    wget

ENV ROCM_PATH=/opt/rocm
ENV PATH="${PATH}:${ROCM_PATH}/bin:${ROCM_PATH}/rocprofiler/bin:${ROCM_PATH}/opencl/bin"
ENV CXX=hipcc
