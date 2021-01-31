FROM ghcr.io/hotio/base@sha256:b3293df11d364305a12e1df4a09304d01589036c8380387d32089ab395b18cc8

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm64v8" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
