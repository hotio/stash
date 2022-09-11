FROM cr.hotio.dev/hotio/base@sha256:32f7802fe9903727645618677d0109a2da34a6d2efbc494f3afae50fdb7b2dd2

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm64v8" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
RUN chmod -R +x /etc/cont-init.d/ /etc/services.d/
