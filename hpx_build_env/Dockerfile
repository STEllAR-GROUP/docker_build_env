# Copyright (c) 2020 Mikael Simberg
# Copyright (c) 2015 Martin Stumpf
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
RUN apt-get update -qq && apt-get install -y -qq --no-install-recommends curl gnupg && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates main restricted" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates universe" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://archive.ubuntu.com/ubuntu focal-updates multiverse" >> /etc/apt/sources.list && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -y -qq    \
                    apt-utils &&                    \
                    apt-get install -qq             \
                    --no-install-recommends -y      \
                    wget zip curl ca-certificates   \
                    clang-12                        \
                    clang-format-12                 \
                    clang-tidy-12                   \
                    jq                              \
                    kmod                            \
                    llvm                            \
                    lld                             \
                    llvm-12-dev                     \
                    libasio-dev                     \
                    libclang-12-dev                 \
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
                    libgoogle-perftools-dev         \
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
                    pkg-config                      \
                    graphviz                        \
                    iwyu                            \
                    devscripts                      \
                    zlib1g-dev                      \
                    wget                            \
                    python3.8-venv


# Get cmake files (in separate RUN command to get cached)
RUN wget -q https://cmake.org/files/v3.19/cmake-3.19.8-Linux-x86_64.tar.gz -O cmake.tar.gz && \
    echo "db0d7d225150dd6e08ce54995e671f9b4801b8e93e22df1eef52339f6bbbecd9  cmake.tar.gz" | sha256sum --check --status && \
    tar --strip-components=1 -C /usr/local -xf cmake.tar.gz && \
    rm cmake.tar.gz

RUN wget -q https://github.com/mozilla/grcov/releases/download/v0.7.1/grcov-linux-x86_64.tar.bz2 -O grcov.tar.bz2 && \
    echo "603196293bed54d7ec6fb6d6f85db27966c4512235c7bd6555e1082e765c5bd2 grcov.tar.bz2" | sha256sum --check --status && \
    tar -jxf grcov.tar.bz2 && \
    mv grcov /usr/bin && \
    rm grcov.tar.bz2


COPY docs_requirements.txt docs_requirements.txt


# Creating a python env to eliminate conflicts with system python packages
ENV PYTHON_VENV=/opt/venv
RUN python3 -m venv $PYTHON_VENV
ENV PATH="$PYTHON_VENV/bin:$PATH"

RUN pip3 install --upgrade pip && pip3 install -r docs_requirements.txt cmake_format && \
    rm /usr/bin/ld && ln -s /usr/bin/ld.lld /usr/bin/ld && cd /tmp && \
    git clone https://github.com/tomtom-international/cpp-dependencies.git && \
    cd cpp-dependencies && cmake . && make -j install && \
    cd /tmp && rm -rf /tmp/cpp-dependencies && \
    git clone --single-branch --branch clang_12 https://github.com/include-what-you-use/include-what-you-use.git && \
    mkdir -p include-what-you-use/build && cd include-what-you-use/build && \
    cmake -DCMAKE_PREFIX_PATH="/usr/lib/llvm-12" -DCMAKE_INSTALL_PREFIX="/usr" .. && make -j install && \
    cd /tmp && rm -rf include-what-you-use && \
    git clone --single-branch --branch 1.4.1 https://github.com/VcDevel/Vc.git && \
    cd Vc && git submodule update --init && \
    mkdir -p build && cd build && \
    cmake -DBUILD_TESTING=OFF .. && make -j install && \
    cd /tmp && rm -rf Vc && \
    rm -rf /var/lib/apt/lists/*

ENV CC clang-12
ENV CXX clang++-12

# IMPORTANT: Did you read the note at the top of the file?
