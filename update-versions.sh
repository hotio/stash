#!/bin/bash
set -exuo pipefail

old_version=$(jq -re '.version' < meta.json)
version=$(curl -fsSL "https://api.github.com/repos/stashapp/stash/releases/tags/latest_develop" | jq -re .target_commitish)
[[ ${version} == "develop" ]] && version=$(curl -fsSL "https://api.github.com/repos/stashapp/stash/commits/develop" | jq -re .sha)
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
version_intel_cr=$(curl -fsSL "https://api.github.com/repos/intel/compute-runtime/releases/latest" | jq -re '.tag_name')
json=$(cat meta.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    --arg version_intel_cr "${version_intel_cr//v/}" \
    '.version = $version | .version_intel_cr = $version_intel_cr' <<< "${json}" | tee meta.json
