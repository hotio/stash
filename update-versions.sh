#!/bin/bash
old_version=$(jq -re '.version' < VERSION.json)
version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/stashapp/stash/releases/tags/latest_develop" | jq -re .target_commitish) || exit 0
[[ -z ${version} ]] && exit 0
[[ ${version} == null ]] && exit 0
[[ ${version} == "develop" ]] && version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/stashapp/stash/commits/develop" | jq -re .sha) || exit 0
version_check() {
    if [[ "${version}" != "${old_version}" ]]; then
        curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/CHECKSUMS_SHA1" -o CHECKSUMS_SHA1 || return 1
        grep -q "${version:0:7}" < CHECKSUMS_SHA1 || return 1
        curl -fsSL "https://github.com/stashapp/stash/releases/download/latest_develop/stash-linux" -o stash || return 1
        checksum="$(sha1sum stash | awk '{print $1}')"
        grep -q "${checksum}" < CHECKSUMS_SHA1 || return 1
    fi
}
version_check || version="${old_version}"
rm -rf CHECKSUMS_SHA1 stash
intel_cr_version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/intel/compute-runtime/releases/latest" | jq -re '.tag_name') || exit 0
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    --arg intel_cr_version "${intel_cr_version//v/}" \
    '.version = $version | .intel_cr_version = $intel_cr_version' <<< "${json}" | tee VERSION.json
