FROM ghcr.io/hotio/base@sha256:0ea6fadb00a658ed770e753712e45e92efc8bb8d394ee09a1de29403cc28a925

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
