# Copyright (c) 2020 R. Tohid
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM fedora:latest

RUN dnf install -y sudo

RUN dnf install -y wget curl
RUN dnf install -y make cmake git 
RUN dnf install -y which findutils
RUN dnf install -y bash-completion
RUN dnf install -y bzip2 zlib-devel
RUN dnf install -y environment-modules

RUN dnf install -y gcc gcc-c++ gcc-gfortran openmpi-devel gdb lcov
RUN dnf install -y llvm clang compiler-rt clang-devel llvm-devel
RUN dnf install -y python3-devel python3 python3-pip python3-flake8

RUN dnf install -y blas blas-devel lapack lapack-devel 
RUN dnf install -y boost-devel hwloc-devel libatomic

RUN dnf install -y vim-enhanced powerline powerline-fonts

RUN groupadd -r stellar
RUN useradd -r -m -g stellar -G wheel stellar
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


WORKDIR /home/stellar/src

# HPX
RUN git clone --depth 1 https://github.com/STELLAR-GROUP/hpx.git
WORKDIR /home/stellar/src/hpx/
RUN mkdir build
WORKDIR /home/stellar/src/hpx/build

RUN chown -R stellar:stellar /home/stellar

USER stellar
RUN cmake -DCMAKE_BUILD_TYPE=Debug \
    -DHPX_WITH_MALLOC=system \
    -DHPX_WITH_EXAMPLES=Off \
    -DHPX_WITH_VIM_YCM=ON  \
    -DCMAKE_INSTALL_PREFIX=/home/stellar/install/hpx/ ..
RUN make -j 20 
