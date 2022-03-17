FROM cr.hotio.dev/hotio/base@sha256:66c1cd47c5b50c6e3826ba7b4d0417ec1acd509b74dea2e51befe66ad63bff7d

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
