FROM ghcr.io/hotio/base@sha256:f61c51dd5ce6b96beb40e0fcd12f422260a724b69c60153e925969830cbe3ba0

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
