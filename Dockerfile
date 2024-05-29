FROM oscarhult/jre21

EXPOSE 25565/tcp 25565/udp

ARG PAPERMC_VERSION
ARG PAPERMC_BUILD

ADD https://api.papermc.io/v2/projects/paper/versions/${PAPERMC_VERSION}/builds/${PAPERMC_BUILD}/downloads/paper-${PAPERMC_VERSION}-${PAPERMC_BUILD}.jar /papermc.jar

WORKDIR /papermc
VOLUME /papermc

ENTRYPOINT ["java", "-XX:+UseG1GC", "-XX:+ParallelRefProcEnabled", "-XX:MaxGCPauseMillis=200", "-XX:+UnlockExperimentalVMOptions", "-XX:+DisableExplicitGC", "-XX:+AlwaysPreTouch", "-XX:G1NewSizePercent=30", "-XX:G1MaxNewSizePercent=40", "-XX:G1HeapRegionSize=8M", "-XX:G1ReservePercent=20", "-XX:G1HeapWastePercent=5", "-XX:G1MixedGCCountTarget=4", "-XX:InitiatingHeapOccupancyPercent=15", "-XX:G1MixedGCLiveThresholdPercent=90", "-XX:G1RSetUpdatingPauseTimePercent=5", "-XX:SurvivorRatio=32", "-XX:+PerfDisableSharedMem", "-XX:MaxTenuringThreshold=1", "-Dusing.aikars.flags=https://mcflags.emc.gs", "-Daikars.new.flags=true", "-Dcom.mojang.eula.agree=true", "-jar", "/papermc.jar", "--nogui", "--nojline"]
