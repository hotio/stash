FROM ghcr.io/hotio/base@sha256:8a0ec9d1e1c36cea119cd3820b348b1983dca9bd893cac0e035127967576ce64

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/CHECKSUMS_SHA1" > "${APP_DIR}/CHECKSUMS_SHA1" && \
    cat "${APP_DIR}/CHECKSUMS_SHA1" | grep "${VERSION:0:8}" && \
    curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/stash-linux" > "${APP_DIR}/stash" && \
    CHECKSUM=$(sha1sum "${APP_DIR}/stash" | awk '{print $1}') && \
    cat "${APP_DIR}/CHECKSUMS_SHA1" | grep "${CHECKSUM}" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
