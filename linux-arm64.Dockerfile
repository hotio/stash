ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}
EXPOSE 9999
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} WEBUI_PORTS="9999/tcp,9999/udp"

ARG DEBIAN_FRONTEND="noninteractive"
# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        gnupg && \
    curl -fsSL "https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key" | apt-key add - && \
    echo "deb [arch=arm64] https://repo.jellyfin.org/ubuntu noble main" | tee /etc/apt/sources.list.d/jellyfin.list && \
    apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
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

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/CHECKSUMS_SHA1" > "${APP_DIR}/CHECKSUMS_SHA1" && \
    grep "${VERSION:0:7}" < "${APP_DIR}/CHECKSUMS_SHA1" && \
    curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/stash-linux-arm64v8" > "${APP_DIR}/stash" && \
    CHECKSUM=$(sha1sum "${APP_DIR}/stash" | awk '{print $1}') && \
    grep "${CHECKSUM}" < "${APP_DIR}/CHECKSUMS_SHA1" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
