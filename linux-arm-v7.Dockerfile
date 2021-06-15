FROM ghcr.io/hotio/base@sha256:3a001a4e2193756a0a43ffbc5f9922fde95560099c5e49f53b9b5a77558ad2bd

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
