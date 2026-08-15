FROM ubuntu:26.04 AS source

ADD --checksum=sha256:ed02e389f064de8e228625dc565e071d04dd555463d568c142d0af91311cb91c https://api.snapcraft.io/api/v1/snaps/download/JUJH91Ved74jd4ZgJCpzMBtYbPOzTlsD_254.snap /tmp/app.snap

RUN apt-get update && \
    apt-get install -y --no-install-recommends squashfs-tools && \
    unsquashfs -quiet -no-progress -d /out /tmp/app.snap usr/lib/slack

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/slack"

COPY --from=source /out/usr/lib/slack /opt/slack

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates libasound2t64 libnss3 libxss1 xdg-utils && \
    ln -sf /opt/slack/slack /usr/bin/slack && \
    cpak-clean-junk

COPY icon.png /usr/share/icons/hicolor/128x128/apps/slack.png
COPY slack.desktop /usr/share/applications/slack.desktop
