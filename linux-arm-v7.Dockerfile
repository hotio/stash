FROM ghcr.io/hotio/base@sha256:2abedbe891bd1b71308b219408feda12d13fe91c3d45cf0203ac862a25dfcfa6

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm32v7" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
