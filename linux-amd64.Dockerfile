FROM ghcr.io/hotio/base@sha256:4a96bd748c0358bcfc43efb8b16ec4689c88cd29c1ed1dfb9090526639710bec

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
