FROM cr.hotio.dev/hotio/base@sha256:6e5edf65a6773ade4287cb8b651d83bd4094c8f23115550ad8ff5b2d6076ad77

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm64v8" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
