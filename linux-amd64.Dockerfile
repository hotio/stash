FROM ghcr.io/hotio/base@sha256:8a0ec9d1e1c36cea119cd3820b348b1983dca9bd893cac0e035127967576ce64

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
