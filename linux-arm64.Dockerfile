FROM ghcr.io/hotio/base@sha256:8856f3a1decd8abb2ffdc3e4aca69e546b474ef7fff0382212f0296f3af58a25

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm64v8" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
