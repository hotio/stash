FROM ghcr.io/hotio/base@sha256:fc9c0387c1150b5d77418a739767102e3383c583aee4ed9e09bf24c41e2fa0f0

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
