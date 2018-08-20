# Copyright (c) 2015 Martin Stumpf
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM debian:stable

# add contrib and non-free to /etc/apt/sources.list as well as clang package
RUN sed -i 's/$/ contrib non-free/' /etc/apt/sources.list && \
    apt-get update && apt-get install -y curl gnupg && \
    echo "deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch-5.0 main" >> /etc/apt/sources.list && \
    echo "deb-src http://apt.llvm.org/stretch/ llvm-toolchain-stretch-5.0 main" >> /etc/apt/sources.list && \
    curl https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

# install dependencies
RUN apt-get update && apt-get install -y            \
                    clang-5.0                       \
                    clang-5.0-doc                   \
                    libclang-common-5.0-dev         \
                    libclang-5.0-dev                \
                    libclang1-5.0                   \
                    libclang1-5.0-dbg               \
                    libllvm5.0                      \
                    llvm-5.0                        \
                    llvm-5.0-dev                    \
                    llvm-5.0-runtime                \
                    clang-format-5.0                \
                    clang-tidy-5.0                  \
                    lld-5.0                         \
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
                    doxygen                         \
                    python                          \
                    python-sphinx                   \
                    python-sphinx-rtd-theme         \
                    python-breathe                  \
                    libjson-perl                    \
                    ninja-build                     \
                    git                             \
                    xsltproc                        \
                    pkg-config &&                   \
    update-alternatives --install /usr/bin/clang++  \
        clang++ /usr/bin/clang++-5.0 100 &&         \
    update-alternatives --install /usr/bin/clang    \
        clang /usr/bin/clang-5.0 100 &&             \
    update-alternatives --install /usr/bin/clang-tidy \
        clang-tidy /usr/bin/clang-tidy-5.0 100 &&   \
    rm /usr/bin/ld && ln -s /usr/bin/ld.lld-5.0 /usr/bin/ld

ENV CC clang
ENV CXX clang++
