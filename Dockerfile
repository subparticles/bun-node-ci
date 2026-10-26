FROM node:26.12.1-bookworm-slim AS node

FROM tdsdockerhub/bun-ci:bun-1.4.4

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        libatomic1 \
        libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=node /usr/local/bin/node /usr/local/bin/node

# Prefer real Node over Bun's node fallback.
ENV PATH="/usr/local/bin:${PATH}"

RUN node --version \
    && bun --version \
    && git --version
