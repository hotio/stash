FROM ghcr.io/hotio/base@sha256:6287fd92cbcf7f0b1aea61c6da898e20859fdf99a1a718351afb3da23d3fe2f8

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm32v7" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
