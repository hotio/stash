FROM ghcr.io/hotio/base@sha256:1b5c9ec2e270fee73368d5600b4e7a411f8a969e9212d6d2bad3b6dce3ec320d

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm32v7" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
