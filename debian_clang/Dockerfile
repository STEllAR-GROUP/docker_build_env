# Copyright (c) 2015 Martin Stumpf
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM debian:testing

# add contrib and non-free to /etc/apt/sources.list
RUN sed -i 's/$/ contrib non-free/' /etc/apt/sources.list

# install dependencies
RUN apt-get update && apt-get install -y            \
                    clang                           \
                    libhwloc-dev                    \
                    cmake                           \
                    libboost-chrono-dev             \
                    libboost-date-time-dev          \
                    libboost-filesystem-dev         \
                    libboost-program-options-dev    \
                    libboost-regex-dev              \
                    libboost-serialization-dev      \
                    libboost-system-dev             \
                    libboost-thread-dev

ENV CC clang
ENV CXX clang++
