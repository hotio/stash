FROM ghcr.io/hotio/base@sha256:bd1ba080a8f623f874c026fa579a1f1b5b6cb5349bbf960a566ecc242db48d0f

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/CHECKSUMS_SHA1" > "${APP_DIR}/CHECKSUMS_SHA1" && \
    cat "${APP_DIR}/CHECKSUMS_SHA1" | grep "${VERSION:0:7}" && \
    curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/stash-linux-arm32v7" > "${APP_DIR}/stash" && \
    CHECKSUM=$(sha1sum "${APP_DIR}/stash" | awk '{print $1}') && \
    cat "${APP_DIR}/CHECKSUMS_SHA1" | grep "${CHECKSUM}" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
