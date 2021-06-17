FROM ghcr.io/hotio/base@sha256:cebb8cd25b2e363f9d63f062833af6b8fc475b6c3ce9f898f1a681930cfd3fc1

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
