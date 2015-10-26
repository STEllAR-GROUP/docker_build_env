# Copyright (c) 2015 Martin Stumpf
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM debian:stable

# add contrib and non-free to /etc/apt/sources.list
RUN sed -i 's/$/ contrib non-free/' /etc/apt/sources.list

# add wget, needed to install clang key
RUN apt-get update && apt-get install -y wget

# add clang repo
RUN sed -i '$a deb http://llvm.org/apt/jessie/ llvm-toolchain-jessie-3.7 main' \
        /etc/apt/sources.list

# add clang key
RUN wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add -

# install dependencies
RUN apt-get update && apt-get install -y            \
                    clang-3.7                       \
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
                    pkg-config

ENV CC clang-3.7
ENV CXX clang++-3.7
