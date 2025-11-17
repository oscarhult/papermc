#!/bin/bash

version=1.21.10

curl -fsL https://fill.papermc.io/v3/projects/paper/versions/${version}/builds | jq '.[0]' > build.json
build=$(jq -r '.id' build.json)
url=$(jq -r '.downloads["server:default"].url' build.json)

id=$(curl -fsL https://hub.docker.com/v2/repositories/oscarhult/papermc/tags/${version}-${build} | jq '.id')

if [[ ! ${id} ]]; then
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
else
    exit 0
fi
