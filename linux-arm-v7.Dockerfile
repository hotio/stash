FROM ghcr.io/hotio/base@sha256:24b945b0e4787dcbb80ebb667536ab233cf3c418cb61434d644c5a7d78606d0f

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm32v7" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
