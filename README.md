[<img src="https://hotio.dev/img/stash.png" alt="logo" height="130" width="130">](https://github.com/stashapp/stash)

[![GitHub Source](https://img.shields.io/badge/github-source-ffb64c?style=flat-square&logo=github&logoColor=white&labelColor=757575)](https://github.com/hotio/stash)
[![GitHub Registry](https://img.shields.io/badge/github-registry-ffb64c?style=flat-square&logo=github&logoColor=white&labelColor=757575)](https://github.com/orgs/hotio/packages/container/package/stash)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/stash?color=ffb64c&style=flat-square&label=pulls&logo=docker&logoColor=white&labelColor=757575)](https://hub.docker.com/r/hotio/stash)
[![Discord](https://img.shields.io/discord/610068305893523457?style=flat-square&color=ffb64c&label=discord&logo=discord&logoColor=white&labelColor=757575)](https://hotio.dev/discord)
[![Upstream](https://img.shields.io/badge/upstream-project-ffb64c?style=flat-square&labelColor=757575)](https://github.com/stashapp/stash)
[![Website](https://img.shields.io/badge/website-hotio.dev-ffb64c?style=flat-square&labelColor=757575)](https://hotio.dev/containers/stash)

## Starting the container

CLI:

```shell
docker run --rm \
    --name stash \
    -p 9999:9999 \
    -e PUID=1000 \
    -e PGID=1000 \
    -e UMASK=002 \
    -e TZ="Etc/UTC" \
    -e ARGS="" \
    -v /<host_folder_config>:/config \
    hotio/stash
```

Compose:

```yaml
version: "3.7"

services:
  stash:
    container_name: stash
    image: hotio/stash
    ports:
      - "9999:9999"
    environment:
      - PUID=1000
      - PGID=1000
      - UMASK=002
      - TZ=Etc/UTC
      - ARGS
    volumes:
      - /<host_folder_config>:/config
```

In most cases you'll need to add additional volumes, depending on your own personal preference, to get access to your files.

## Tags

| Tag                | Upstream                           | Version | Build |
| -------------------|------------------------------------|---------|-------|
| `release` (latest) | GitHub releases                    | ![version](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhotio%2Fstash%2Frelease%2FVERSION.json) | ![build](https://img.shields.io/github/workflow/status/hotio/stash/build/release?style=flat-square&label=) |

You can also find tags that reference a commit or version number.

## Configuration location

Your stash configuration inside the container is stored in `/config/app`.
