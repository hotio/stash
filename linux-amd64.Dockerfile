FROM ghcr.io/hotio/base@sha256:1a0aa67c51aa3789f3453e7d0e000149ac67dc1f6bb9173d4ee6243cc83597ce

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
