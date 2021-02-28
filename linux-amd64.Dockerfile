FROM ghcr.io/hotio/base@sha256:ea5ee7980a86462fd41854214858fd9cb26a0917be8d8eaf8890e9aa295e866b

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
