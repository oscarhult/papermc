#!/bin/bash
set -euo pipefail

version=1.21.11

curl -fsL https://fill.papermc.io/v3/projects/paper/versions/${version}/builds \
  | jq '.[0]' > build.json

build=$(jq -r '.id' build.json)
url=$(jq -r '.downloads["server:default"].url' build.json)

# Ensure jq outputs empty instead of null
id=$(curl -fsL https://hub.docker.com/v2/repositories/oscarhult/papermc/tags/${version}-${build} \
  | jq -r '.id // empty')

# Abort script if id is empty
if [[ -z "$id" ]]; then
  echo "id is empty, aborting build."
  exit 1
fi

tag1=oscarhult/papermc:${version}-${build}
tag2=oscarhult/papermc:${version}
tag3=oscarhult/papermc:latest

docker build . \
  --tag ${tag1} \
  --tag ${tag2} \
  --tag ${tag3} \
  --build-arg PAPERMC_URL=${url}

docker login -u oscarhult --password-stdin <<< ${DOCKER_ACCESS_TOKEN}

docker push ${tag1}
docker push ${tag2}
docker push ${tag3}
