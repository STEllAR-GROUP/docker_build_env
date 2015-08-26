# Copyright (c) 2015 Patrick Diehl
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM fedora:22
MAINTAINER Patrick Diehl <diehl@ins.uni-bonn.de>
# install dependencies
RUN dnf update -y
RUN dnf install -y \ 
cmake \
boost-build \
boost \
boost-devel \ 
hwloc-devel \
hwloc \
gcc-gfortran \
papi-devel \
gperftools-devel \ 
docbook-dtds \
docbook-style-xsl \ 
libsodium-devel \
doxygen \
boost-doc \ 
hdf5-devel \
fop \
boost-devel \ 
boost-openmpi-devel \ 
boost-mpich-devel 

ENV CC gcc
ENV CXX g++
