version=1.17.1
build=409

tag1=oscarhult/papermc:${version}-${build}
tag2=oscarhult/papermc:${version}

docker build . \
    --pull \
    --tag ${tag1} \
    --tag ${tag2} \
    --build-arg PAPERMC_VERSION=${version} \
    --build-arg PAPERMC_BUILD=${build}

docker push ${tag1}
docker push ${tag2}