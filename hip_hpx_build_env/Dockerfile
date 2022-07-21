# Copyright (c) 2020 ETH Zurich
#
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

FROM stellargroup/build_env:13

ENV DEBIAN_FRONTEND=noninteractive

# Install ROCm
RUN wget -q -O - https://repo.radeon.com/rocm/rocm.gpg.key | apt-key add - && \
    echo 'deb [arch=amd64] https://repo.radeon.com/rocm/apt/debian/ ubuntu main' | \
    tee /etc/apt/sources.list.d/rocm.list && apt-get update -qq && \
    apt-get install -qq -y rocm-dev rocm-libs hipblas && \
    rm -rf /var/lib/apt/lists/*

ENV ROCM_PATH=/opt/rocm
ENV PATH="${PATH}:${ROCM_PATH}/bin:${ROCM_PATH}/rocprofiler/bin:${ROCM_PATH}/opencl/bin"
ENV CXX hipcc
