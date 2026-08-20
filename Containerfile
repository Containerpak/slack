FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/slack"

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates libasound2t64 libnss3 libxss1 xdg-utils && \
    cpak-clean-junk
