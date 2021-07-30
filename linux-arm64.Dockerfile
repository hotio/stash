FROM ghcr.io/hotio/base@sha256:fc660a53878523289966e0c154de17d7c393cd7c33f2773a3f4db92765083286

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm64v8" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
