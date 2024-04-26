#!/bin/bash
old_version=$(jq -re '.version' < VERSION.json)
version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/stashapp/stash/releases/latest" | jq -re .tag_name) || exit 1
[[ -z ${version} ]] && exit 0
[[ ${version} == null ]] && exit 0
if [[ "${version}" != "v${old_version}" ]]; then
    curl -fsSL "https://github.com/stashapp/stash/releases/download/${version}/stash-linux" -o /dev/null || exit 1
    json=$(cat VERSION.json)
    jq --sort-keys \
        --arg version "${version//v/}" \
        '.version = $version' <<< "${json}" | tee VERSION.json
fi
