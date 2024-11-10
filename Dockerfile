FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04


ENV NVIDIA_VISIBLE_DEVICES=all \
    PATH=/usr/local/cuda/bin:/usr/local/nvidia/bin:/root/.local/bin:${PATH} \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    NVIDIA_REQUIRE_CUDA="cuda>=11.3" \
    CUDA_VERSION=11.3.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \ 
        curl \
        wget \
        ca-certificates \
        xz-utils \
        software-properties-common \
        unzip \ 
        python3-setuptools \
        build-essential \
        python3-pip \
        python3-dev

RUN cd /usr/bin \
	&& ln -s idle3 idle \
	&& ln -s pydoc3 pydoc \
	&& ln -s python3 python \
	&& ln -s python3-config python-config


ENV LOLMINER_VERSION=1.84
RUN mkdir lolminer \
    && wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/${LOLMINER_VERSION}/lolMiner_v${LOLMINER_VERSION}_Lin64.tar.gz \
    && tar -xvzf lolMiner_v${LOLMINER_VERSION}_Lin64.tar.gz -C lolminer \
    && mv lolminer/${LOLMINER_VERSION}/lolMiner /usr/local/bin \
    && chmod +x /usr/local/bin/lolMiner

RUN curl -sL https://repo.chia.net/FD39E6D3.pubkey.asc | gpg --dearmor -o /usr/share/keyrings/chia.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/chia.gpg] https://repo.chia.net/debian/ stable main" | tee /etc/apt/sources.list.d/chia.list > /dev/null \
    && apt-get update \
    && apt-get install -y chia-blockchain-cli

RUN mkdir gminer \
    && curl -L https://github.com/develsoftware/GMinerRelease/releases/download/3.44/gminer_3_44_linux64.tar.xz | tar xJv -C gminer \
    && mv gminer/miner /usr/local/bin \
    && chmod +x /usr/local/bin/miner


RUN mkdir rigel \
    && curl -L https://github.com/rigelminer/rigel/releases/download/1.19.1/rigel-1.19.1-linux.tar.gz | tar -xz -C rigel \
    && mv rigel/rigel-1.19.1-linux/rigel /usr/local/bin \
    && chmod +x /usr/local/bin/rigel
RUN ln -s /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so
ADD ./chia_entrypoint.sh chia_entrypoint.sh

RUN mkdir t-rex \
    && curl -L https://trex-miner.com/download/t-rex-0.26.8-linux.tar.gz | tar xz -C t-rex \
    && mv t-rex/t-rex /usr/local/bin \
    && chmod +x /usr/local/bin/t-rex
