#!/bin/bash
old_version=$(jq -re '.version' < VERSION.json)
version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/stashapp/stash/releases/latest" | jq -re .tag_name) || exit 1
[[ -z ${version} ]] && exit 0
[[ ${version} == null ]] && exit 0
if [[ "${version}" != "v${old_version}" ]]; then
    curl -fsSL "https://github.com/stashapp/stash/releases/download/${version}/stash-linux" -o /dev/null || exit 0
fi
intel_cr_version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/intel/compute-runtime/releases/latest" | jq -re '.tag_name') || exit 1
intel_gc_version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/intel/intel-graphics-compiler/releases/latest" | jq -re '.tag_name') || exit 1
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    --arg intel_cr_version "${intel_cr_version//v/}" \
    --arg intel_gc_version "${intel_gc_version//v/}" \
    '.version = $version | .intel_cr_version = $intel_cr_version | .intel_gc_version = $intel_gc_version' <<< "${json}" | tee VERSION.json
