version=1.18.1
build=207

tag1=oscarhult/papermc:${version}-${build}
tag2=oscarhult/papermc:${version}
tag3=oscarhult/papermc:latest

docker build . \
    --pull \
    --tag ${tag1} \
    --tag ${tag2} \
    --tag ${tag3} \
    --build-arg PAPERMC_VERSION=${version} \
    --build-arg PAPERMC_BUILD=${build}

docker push ${tag1}
docker push ${tag2}
docker push ${tag3}