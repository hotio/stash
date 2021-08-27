FROM ghcr.io/hotio/base@sha256:f5c1af3194805696f6f7fe2d3b1fd3357396cfaa22ec319170c7eb8aaa1d237a

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm32v7" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
