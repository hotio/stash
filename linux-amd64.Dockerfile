FROM cr.hotio.dev/hotio/base@sha256:28bb946f53b50b204e0c14ea79daf2eed22b096a4cbc969d13710e9e66be7a3e

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
