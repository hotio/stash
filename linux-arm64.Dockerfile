FROM cr.hotio.dev/hotio/base@sha256:9f4741371043929c19ed6b7468b18aa9e07c66143ffe92bf8c2e2ff78d0193fa

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm64v8" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
