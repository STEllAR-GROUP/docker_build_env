# Copyright (c) 2015 Martin Stumpf
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
                    ninja-build                     \
                    git                             \
                    pkg-config                      \
                    wget                            \
                    xsltproc                        \
                    doxygen                         \
                    libpng-dev

#Installation of CUDA 8.0
RUN wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run && \
    chmod +x cuda_8.0.61_375.26_linux-run && \
    mkdir nvidia_installers && \
    ./cuda_8.0.61_375.26_linux-run -extract=`pwd`/nvidia_installers && \
    cd nvidia_installers && \
    ./cuda-linux64-rel-8.0.61-21551265.run -noprompt && \
    cd .. && \
    rm -r nvidia_installers


ENV CC clang
ENV CXX clang++
