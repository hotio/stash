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
intel_cr_version=$(curl -fsSL "https://api.github.com/repos/intel/compute-runtime/releases/latest" | jq -re '.tag_name')
json=$(cat meta.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    --arg intel_cr_version "${intel_cr_version//v/}" \
    '.version = $version | .intel_cr_version = $intel_cr_version' <<< "${json}" | tee meta.json
