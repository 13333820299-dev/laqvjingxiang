FROM debian:12-slim

ARG MILVUS_BACKUP_VERSION=v0.5.12
ARG TARGETARCH

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    tar \
    bash \
    coreutils \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    case "${TARGETARCH}" in \
      amd64) ARCH="x86_64" ;; \
      arm64) ARCH="arm64" ;; \
      *) echo "Unsupported TARGETARCH=${TARGETARCH}"; exit 1 ;; \
    esac; \
    curl -fL -o /tmp/milvus-backup.tar.gz \
      "https://github.com/zilliztech/milvus-backup/releases/download/${MILVUS_BACKUP_VERSION}/milvus-backup_Linux_${ARCH}.tar.gz"; \
    tar -xzf /tmp/milvus-backup.tar.gz -C /tmp; \
    find /tmp -type f -name milvus-backup -exec cp {} /usr/local/bin/milvus-backup \;; \
    chmod +x /usr/local/bin/milvus-backup; \
    rm -rf /tmp/*

CMD ["/bin/bash", "-c", "echo 'image ready'; sleep infinity"]
