ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_AMD64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_AMD64}
EXPOSE 9999
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} WEBUI_PORTS="9999/tcp,9999/udp"

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        ffmpeg python3-pip && \
    pip3 install --break-system-packages --no-cache-dir --upgrade \
        stashapp-tools cloudscraper && \
# clean up
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
