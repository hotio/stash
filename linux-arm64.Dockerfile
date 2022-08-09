FROM cr.hotio.dev/hotio/base@sha256:395f6abf5a3965353a307032ca2dc4dafa66a048b1358211dec6d6b6fb8d2ed7

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/CHECKSUMS_SHA1" > "${APP_DIR}/CHECKSUMS_SHA1" && \
    cat "${APP_DIR}/CHECKSUMS_SHA1" | grep "${VERSION:0:7}" && \
    curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/stash-linux-arm64v8" > "${APP_DIR}/stash" && \
    CHECKSUM=$(sha1sum "${APP_DIR}/stash" | awk '{print $1}') && \
    cat "${APP_DIR}/CHECKSUMS_SHA1" | grep "${CHECKSUM}" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
