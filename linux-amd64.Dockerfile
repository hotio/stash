ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_AMD64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_AMD64}
EXPOSE 9999
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} WEBUI_PORTS="9999/tcp,9999/udp"

ARG DEBIAN_FRONTEND="noninteractive"
# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        gnupg && \
    curl -fsSL "https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key" | apt-key add - && \
    echo "deb [arch=amd64] https://repo.jellyfin.org/ubuntu noble main" | tee /etc/apt/sources.list.d/jellyfin.list && \
    apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        ocl-icd-libopencl1 \
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

# https://github.com/intel/compute-runtime/releases
# https://github.com/intel/intel-graphics-compiler/releases
ARG INTEL_CR_VERSION
ARG INTEL_GC_VERSION
RUN mkdir /tmp/intel-compute-runtime && \
    cd /tmp/intel-compute-runtime && \
    curl -fsSL "https://api.github.com/repos/intel/compute-runtime/releases/tags/${INTEL_CR_VERSION}" | jq -r '.assets[].browser_download_url' | grep -e "libigdgmm.*\.deb" >> list.txt && \
    curl -fsSL "https://api.github.com/repos/intel/compute-runtime/releases/tags/${INTEL_CR_VERSION}" | jq -r '.assets[].browser_download_url' | grep -e "intel-opencl-icd.*\.deb" >> list.txt && \
#    INTEL_GC_VERSION=2.8.3 && \
    curl -fsSL "https://api.github.com/repos/intel/intel-graphics-compiler/releases/tags/v${INTEL_GC_VERSION}" | jq -r '.assets[].browser_download_url' | grep -e "intel-igc-core-2.*\.deb" >> list.txt && \
    curl -fsSL "https://api.github.com/repos/intel/intel-graphics-compiler/releases/tags/v${INTEL_GC_VERSION}" | jq -r '.assets[].browser_download_url' | grep -e "intel-igc-opencl-2.*\.deb" >> list.txt && \
    echo "https://github.com/intel/compute-runtime/releases/download/24.35.30872.22/intel-opencl-icd-legacy1_24.35.30872.22_amd64.deb" >> list.txt && \
    echo "https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.17537.20/intel-igc-core_1.0.17537.20_amd64.deb" >> list.txt && \
    echo "https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.17537.20/intel-igc-opencl_1.0.17537.20_amd64.deb" >> list.txt && \
    wget -i list.txt && \
    dpkg -i *.deb && \
    cd .. && \
    rm -rf /tmp/*

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/CHECKSUMS_SHA1" > "${APP_DIR}/CHECKSUMS_SHA1" && \
    grep "${VERSION:0:7}" < "${APP_DIR}/CHECKSUMS_SHA1" && \
    curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/stash-linux" > "${APP_DIR}/stash" && \
    CHECKSUM=$(sha1sum "${APP_DIR}/stash" | awk '{print $1}') && \
    grep "${CHECKSUM}" < "${APP_DIR}/CHECKSUMS_SHA1" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
