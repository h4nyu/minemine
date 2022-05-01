FROM debian:bullseye-slim

ENV CUDA_VERSION 11.2.2
ENV CUDA_PKG_VERSION 10-2=$CUDA_VERSION-1
ENV NVIDIA_VISIBLE_DEVICES all
ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.2 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 driver>=450,driver<451"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \ 
        gnupg2 curl ca-certificates xz-utils software-properties-common unzip \ 
        python3-setuptools \
        python3-pip \
        git \ 
        sudo \
        watch \
    && curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub | apt-key add - \
    && echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list \
    && echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        cuda-cudart-11-2=11.2.152-1 \
        cuda-compat-11-2 \
    && ln -s cuda-11.2 /usr/local/cuda

RUN cd /usr/bin \
	&& ln -s idle3 idle \
	&& ln -s pydoc3 pydoc \
	&& ln -s python3 python \
	&& ln -s python3-config python-config


RUN mkdir ethminer \
    && curl -sL https://github.com/ethereum-mining/ethminer/releases/download/v0.18.0/ethminer-0.18.0-cuda-9-linux-x86_64.tar.gz | tar xz -C ethminer \
    && mv ethminer/bin/ethminer /usr/local/bin \
    && chmod +x /usr/local/bin/ethminer

RUN mkdir gminer \
    && curl -sL https://github.com/develsoftware/GMinerRelease/releases/download/2.90/gminer_2_90_linux64.tar.xz | tar xJv -C gminer \
    && mv gminer/miner /usr/local/bin \
    && chmod +x /usr/local/bin/miner

RUN git clone --depth=1 https://github.com/Chia-Network/chia-blockchain.git -b 1.3.4 --recurse-submodules \
    && cd chia-blockchain \
    && python setup.py install \
    && chia init 

ADD ./chia_entrypoint.sh chia_entrypoint.sh
