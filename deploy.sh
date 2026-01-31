#!/bin/bash
set -euo pipefail

version=1.21.11

# Fetch latest build metadata
build_json=$(curl -fsL "https://fill.papermc.io/v3/projects/paper/versions/${version}/builds" | jq '.[0]')

build=$(jq -r '.id // empty' <<< "$build_json")
url=$(jq -r '.downloads["server:default"].url // empty' <<< "$build_json")

# Abort if build or url is missing
if [[ -z "$build" || -z "$url" ]]; then
  echo "Failed to resolve latest build or download URL"
  exit 1
fi

tag="${version}-${build}"

# Check if tag already exists on Docker Hub
tag_id=$(curl -fsL \
  "https://hub.docker.com/v2/repositories/oscarhult/papermc/tags/${tag}" \
  | jq -r '.id // empty' || true)

# If tag exists, do nothing
if [[ -n "$tag_id" ]]; then
  echo "Tag ${tag} already exists, skipping build"
  exit 0
fi

echo "Tag ${tag} not found, building and pushing"

tag1="oscarhult/papermc:${version}-${build}"
tag2="oscarhult/papermc:${version}"
tag3="oscarhult/papermc:latest"

docker build . \
  --tag "${tag1}" \
  --tag "${tag2}" \
  --tag "${tag3}" \
  --build-arg PAPERMC_URL="${url}"

docker login -u oscarhult --password-stdin <<< "${DOCKER_ACCESS_TOKEN}"

docker push "${tag1}"
docker push "${tag2}"
docker push "${tag3}"
