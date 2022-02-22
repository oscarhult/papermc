https://papermc.io

https://github.com/GoogleContainerTools/distroless

https://aikar.co/mcflags.html

https://containrrr.dev/watchtower/

```
docker volume create papermc
docker stop papermc
docker rm papermc
docker run \
    --detach \
    --pull always \
    --restart unless-stopped \
    --env JAVA_TOOL_OPTIONS="-Xms4G -Xmx4G" \
    --publish 25565:25565/tcp \
    --publish 25565:25565/udp \
    --name papermc \
    --volume papermc:/papermc \
    oscarhult/papermc:latest
```
