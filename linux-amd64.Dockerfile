FROM cr.hotio.dev/hotio/base@sha256:2d9fc1f1bab038667b32091957c25ad15301f73f9392c742c0ab273da68a18ed

EXPOSE 9999

RUN apk add --no-cache ffmpeg python3 py3-requests sqlite-libs

ARG VERSION
RUN curl -fsSL "https://github.com/stashapp/stash/releases/download/v${VERSION}/stash-linux" > "${APP_DIR}/stash" && \
    chmod 755 "${APP_DIR}/stash"

COPY root/ /
