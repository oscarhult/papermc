FROM oscarhult/jre25

EXPOSE 25565/tcp 25565/udp

RUN apk add --no-cache libstdc++

ARG PAPERMC_URL

ADD ${PAPERMC_URL} /papermc.jar

WORKDIR /papermc
VOLUME /papermc

ENTRYPOINT ["java", "-XX:+AlwaysPreTouch", "-XX:+DisableExplicitGC", "-XX:+ParallelRefProcEnabled", "-XX:+PerfDisableSharedMem", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseG1GC", "-XX:G1HeapRegionSize=8M", "-XX:G1HeapWastePercent=5", "-XX:G1MaxNewSizePercent=40", "-XX:G1MixedGCCountTarget=4", "-XX:G1MixedGCLiveThresholdPercent=90", "-XX:G1NewSizePercent=30", "-XX:G1RSetUpdatingPauseTimePercent=5", "-XX:G1ReservePercent=20", "-XX:InitiatingHeapOccupancyPercent=15", "-XX:MaxGCPauseMillis=200", "-XX:MaxTenuringThreshold=1", "-XX:SurvivorRatio=32", "-Dcom.mojang.eula.agree=true", "-jar", "/papermc.jar", "--nogui", "--nojline" ]