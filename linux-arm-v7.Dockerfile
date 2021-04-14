FROM ghcr.io/hotio/base@sha256:6fa9179cf9aa06dd0d03645fb5920bf2fa7edf73e3505f34b59ecfcf7340a2c6

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm32v7" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
