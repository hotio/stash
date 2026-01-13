#!/bin/bash
set -exuo pipefail

old_version=$(jq -re '.version' < meta.json)
version=$(curl -fsSL "https://api.github.com/repos/stashapp/stash/releases/latest" | jq -re .tag_name)
version_check() {
    if [[ "${version}" != "${old_version}" ]]; then
        curl -fsSL "https://github.com/stashapp/stash/releases/download/${version}/stash-linux" -o /dev/null || return 1
    fi
}
version_check || version="${old_version}"
version_intel_cr=$(curl -fsSL "https://api.github.com/repos/intel/compute-runtime/releases/latest" | jq -re '.tag_name')
json=$(cat meta.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    --arg version_intel_cr "${version_intel_cr//v/}" \
    '.version = $version | .version_intel_cr = $version_intel_cr' <<< "${json}" | tee meta.json
