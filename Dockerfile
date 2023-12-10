FROM debian:bullseye-slim

ENV NVIDIA_VISIBLE_DEVICES=all \
    PATH=/usr/local/cuda/bin:/usr/local/nvidia/bin:/root/.local/bin:${PATH} \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    NVIDIA_REQUIRE_CUDA="cuda>=11.3" \
    CUDA_VERSION=11.3.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \ 
        gnupg2 \
        curl \
        wget \
        ca-certificates \
        xz-utils \
        software-properties-common \
        unzip \ 
        gnupg \
        python3-setuptools \
        build-essential \
        python3-pip \
        python3-dev \
        git \ 
        sudo \
        watch \
    && curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub | apt-key add - \
    && echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        cuda-cudart-11-3=11.3.109-1 \
        cuda-compat-11-3 \
        && ln -s cuda-11.3 /usr/local/cuda 

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
    && curl -sL https://github.com/develsoftware/GMinerRelease/releases/download/3.43/gminer_3_43_linux64.tar.xz | tar xJv -C gminer \
    && mv gminer/miner /usr/local/bin \
    && chmod +x /usr/local/bin/miner


RUN mkdir lolminer \
    && wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.76/lolMiner_v1.76_Lin64.tar.gz \
    && tar -xvzf lolMiner_v1.76_Lin64.tar.gz -C lolminer \
    && mv lolminer/1.76/lolMiner /usr/local/bin \
    && chmod +x /usr/local/bin/lolMiner

RUN curl -sL https://repo.chia.net/FD39E6D3.pubkey.asc | gpg --dearmor -o /usr/share/keyrings/chia.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/chia.gpg] https://repo.chia.net/debian/ stable main" | tee /etc/apt/sources.list.d/chia.list > /dev/null \
    && apt-get update \
    && apt-get install -y chia-blockchain-cli



ADD ./chia_entrypoint.sh chia_entrypoint.sh
