# Copyright (c) 2015 Martin Stumpf
#               2015 Patrick Diehl
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM debian:stable

# add contrib and non-free to /etc/apt/sources.list
RUN sed -i 's/$/ contrib non-free/' /etc/apt/sources.list

# install dependencies
RUN apt-get update && apt-get install -y            \
                    clang                           \
                    libhwloc-dev                    \
                    cmake                           \
                    libboost-atomic-dev             \
                    libboost-chrono-dev             \
                    libboost-date-time-dev          \
                    libboost-filesystem-dev         \
                    libboost-program-options-dev    \
                    libboost-regex-dev              \
                    libboost-system-dev             \
                    libboost-thread-dev             \
                    pkg-config                      \
                    build-essential                 \
                    git                             \
                    wget
#Install Cuda
RUN wget http://developer.download.nvidia.com/compute/cuda/7_0/Prod/local_installers/cuda_7.0.28_linux.run && \
    chmod +x cuda_7.0.28_linux.run && \
    mkdir nvidia_installers && \
    ./cuda_7.0.28_linux.run -extract=`pwd`/nvidia_installers && \
    cd nvidia_installers && \
    ./cuda-linux64-rel-7.0.28-19326674.run -noprompt && \
    cd .. && \
    rm -r nvidia_installers

ENV LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-7.0/lib64
ENV PATH=$PATH:/usr/local/cuda-7.0/bin

ENV CC clang
ENV CXX clang++
