#!/bin/bash

version=1.21.6
build=$(curl -fsL https://api.papermc.io/v2/projects/paper/versions/${version}/builds | jq '.builds | max_by(.build) | .build')
id=$(curl -fsL https://hub.docker.com/v2/repositories/oscarhult/papermc/tags/${version}-${build} | jq '.id')

if [[ ! ${id} ]]; then
  tag1=oscarhult/papermc:${version}-${build}
  tag2=oscarhult/papermc:${version}
  tag3=oscarhult/papermc:latest

  docker build . \
    --tag ${tag1} \
    --tag ${tag2} \
    --tag ${tag3} \
    --build-arg PAPERMC_VERSION=${version} \
    --build-arg PAPERMC_BUILD=${build}

  docker login -u oscarhult --password-stdin <<< ${DOCKER_ACCESS_TOKEN}

  docker push ${tag1}
  docker push ${tag2}
  docker push ${tag3}
else
    curl -fsL https://api.papermc.io/v2/projects/paper/versions/${version}/builds | jq '.builds | max_by(.build)'
    curl -fsL https://hub.docker.com/v2/repositories/oscarhult/papermc/tags/${version}-${build} | jq '.'
fi
