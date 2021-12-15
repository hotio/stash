FROM cr.hotio.dev/hotio/base@sha256:e28f9db9b07028f25b57ef1c0ac9e464af5a5b313677fae9c47ca2b13dbdd7d2

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
