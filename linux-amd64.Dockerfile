FROM ghcr.io/hotio/base@sha256:4dcb1ba156a481dd87a1df46a3df05300aafa5ed9985c7027094d77d4a2a4f30

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
