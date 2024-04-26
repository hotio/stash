#!/bin/bash
old_version=$(jq -re '.version' < VERSION.json)
version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/stashapp/stash/releases/tags/latest_develop" | jq -re .target_commitish) || exit 1
[[ -z ${version} ]] && exit 0
[[ ${version} == null ]] && exit 0
[[ ${version} == "develop" ]] && version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/stashapp/stash/commits/develop" | jq -re .sha) || exit 1
if [[ "${version}" != "${old_version}" ]]; then
    curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/CHECKSUMS_SHA1" -o CHECKSUMS_SHA1 || exit 1
    grep -q "${version:0:7}" < CHECKSUMS_SHA1 || exit 1
    curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/stash-linux" -o stash || exit 1
    checksum="$(sha1sum stash | awk '{print $1}')"
    grep -q "${checksum}" < CHECKSUMS_SHA1 || exit 1
    rm -rf CHECKSUMS_SHA1 stash
    json=$(cat VERSION.json)
    jq --sort-keys \
        --arg version "${version//v/}" \
        '.version = $version' <<< "${json}" | tee VERSION.json
fi
