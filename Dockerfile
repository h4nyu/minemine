FROM debian:buster-slim

ENV CUDA_VERSION 11.1.1 
ENV CUDA_PKG_VERSION 10-2=$CUDA_VERSION-1
ENV NVIDIA_VISIBLE_DEVICES all
ENV PATH /usr/local/cuda/bin:/usr/local/nvidia/bin:/root/.poetry/bin:${PATH}
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.1 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 driver>=450,driver<451"

RUN apt-get update \
    && apt-get install -y --no-install-recommends gnupg2 curl ca-certificates \ 
    && curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub | apt-key add - \
    && echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list \
    && echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        cuda-cudart-11-1=11.1.74-1 \
        cuda-compat-11-1 \
    && ln -s cuda-11.2 /usr/local/cuda \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir ethminer \
    && curl -sL https://github.com/ethereum-mining/ethminer/releases/download/v0.18.0/ethminer-0.18.0-cuda-9-linux-x86_64.tar.gz | tar xz -C ethminer \
    && mv ethminer/bin/ethminer /usr/local/bin \
    && chmod +x /usr/local/bin/ethminer
