FROM ghcr.io/hotio/base@sha256:36b96946e2d3480de7e5212b33b07a56aa65052f26ce33cacdce7e84a88a6c5a

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
