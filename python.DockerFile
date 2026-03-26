FROM m.daocloud.io/docker.io/library/python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
    curl \
    wget \
    git \
    iputils-ping \
    net-tools \
    telnet \
    procps \
    less \
    unzip \
    tzdata \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN python -m pip install --upgrade pip setuptools wheel && \
    pip install \
    numpy \
    pandas \
    requests \
    pymysql \
    pyyaml \
    pymilvus \
    scipy \
    tqdm

CMD ["/bin/bash"]
