FROM ghcr.io/hotio/base@sha256:d8582ff9dab61d63a2b07d3442b9f991a895d76a9890ab7380e6871dfeedf17c

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm32v7" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
