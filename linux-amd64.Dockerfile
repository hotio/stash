FROM cr.hotio.dev/hotio/base@sha256:91b2ffed92f1c9af992cc6c82b7431cd9cbee120bb3e40aa0a714c63ed82a3dd

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
