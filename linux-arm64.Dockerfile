FROM cr.hotio.dev/hotio/base@sha256:d4367f0bb0eebf886d2f0ae3edb724de753b6e3f59fa543207c1c71dd465686d

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm64v8" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
