FROM ghcr.io/hotio/base@sha256:1e9d6c1a210c7c3f00efb9fde7f5c37047ca6cb024092ab5fa0d89a6cea26053

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/CHECKSUMS_SHA1" > "${APP_DIR}/CHECKSUMS_SHA1" && \
    cat "${APP_DIR}/CHECKSUMS_SHA1" | grep "${VERSION:0:8}" && \
    curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/stash-linux-arm32v7" > "${APP_DIR}/stash" && \
    CHECKSUM=$(sha1sum "${APP_DIR}/stash" | awk '{print $1}') && \
    cat "${APP_DIR}/CHECKSUMS_SHA1" | grep "${CHECKSUM}" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
