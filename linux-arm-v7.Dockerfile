FROM ghcr.io/hotio/base@sha256:3a001a4e2193756a0a43ffbc5f9922fde95560099c5e49f53b9b5a77558ad2bd

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm32v7" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
