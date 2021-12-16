FROM cr.hotio.dev/hotio/base@sha256:7f510068c37d6cf25f3d8c2b0e9630791a8c244b30ff91fa684f4e0f1f2bf83a

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux-arm32v7" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
