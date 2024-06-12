# Copyright (c) 2024 Panos Syskakis
# Copyright (c) 2020 Mikael Simberg
# Copyright (c) 2015 Martin Stumpf
# Copyright (c) 2023 Hartmut Kaiser
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# The images built from this Dockerfile are versioned with an incrementing
# number in .circleci/config.yml. The version is set in the environment variable
# IMAGE_NAME_VERSIONED.
#
# IMPORTANT: Unless you are 100% sure that the changes to this file will produce
# an image that is compatible with the previous image please increment the
# version!  Incrementing the version means that the image used for e.g. ChplX CI
# can be updated and tested in a separate PR without risking breaking open pull
# request builds.

FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update -qq && apt-get install -y -qq    \
        apt-utils &&                    \
    apt-get install -qq --no-install-recommends -y  \
        clang-15                        \
        clang-tools-15                  \
        clang-15-doc                    \
        libclang-common-15-dev          \
        libclang-15-dev                 \
        libclang1-15                    \
        clang-format-15                 \
        clangd-15                       \
        clang-tidy-15                   \
        libc++-15-dev                   \
        libc++abi-15-dev                \
        libllvm-15-ocaml-dev            \
        libllvm15                       \
        llvm-15                         \
        llvm-15-dev                     \
        llvm-15-doc                     \
        llvm-15-examples                \
        llvm-15-runtime                 \
        libc++1-15                      \
        libc++abi1-15                   \
        liblldb-15-dev                  \
        libomp-15-dev                   \
        libomp5-15                      \
        lld-15                          \
        zip curl                        \
        jq                              \
        kmod                            \
        libasio-dev                     \
        libhwloc-dev                    \
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
        vc-dev                          \
        ninja-build                     \
        git                             \
        pkg-config                      \
        devscripts                      \
        zlib1g-dev                      \
        python3                         \
        python3-pip                     \
        cmake


RUN pip3 install psutil

ENV CC clang-15
ENV CXX clang++-15

# # IMPORTANT: Did you read the note at the top of the file?