`papermc.sh`

```
version=$1
build=$2

tag1=oscarhult/papermc:${version}-${build}
tag2=oscarhult/papermc:${version}
tag3=oscarhult/papermc:latest

docker build \
  --no-cache \
  --pull \
  --tag ${tag1} \
  --tag ${tag2} \
  --tag ${tag3} \
  --build-arg PAPERMC_VERSION=${version} \
  --build-arg PAPERMC_BUILD=${build} \
  'https://github.com/oscarhult/papermc.git'

docker push ${tag1}
docker push ${tag2}
docker push ${tag3}
```

`./papermc.sh 1.18.2 348`
