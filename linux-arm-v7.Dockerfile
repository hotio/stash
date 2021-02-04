FROM ghcr.io/hotio/base@sha256:c564bcaf3fcbe846e5d85a9aca3c3c6812d23d0bbcda62ef573e1c47ad5700ac

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm32v7" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
