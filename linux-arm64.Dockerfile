ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}
EXPOSE 9999
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} WEBUI_PORTS="9999/tcp"

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm64v8" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

ARG DEBIAN_FRONTEND="noninteractive"
# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        gnupg && \
    curl -fsSL "https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key" | apt-key add - && \
    echo "deb [arch=arm64] https://repo.jellyfin.org/ubuntu noble main" | tee /etc/apt/sources.list.d/jellyfin.list && \
    apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        libvips-tools \
        python3-pip \
        jellyfin-ffmpeg7 && \
    pip3 install --break-system-packages --no-cache-dir --upgrade \
        bs4 \
        cloudscraper \
        fastbencode \
        lxml \
        mechanicalsoup \
        pystashlib \
        requests \
        requests-toolbelt \
        stashapp-tools && \
    ln -s /usr/lib/jellyfin-ffmpeg/ffmpeg /usr/bin/ffmpeg && \
    ln -s /usr/lib/jellyfin-ffmpeg/ffprobe /usr/bin/ffprobe && \
    ln -s /usr/lib/jellyfin-ffmpeg/vainfo /usr/bin/vainfo && \
# clean up
    apt purge -y gnupg && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY root/ /
RUN find /etc/s6-overlay/s6-rc.d -name "run*" -execdir chmod +x {} +
