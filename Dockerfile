FROM ghcr.io/linuxserver/baseimage-alpine:3.22

LABEL org.opencontainers.image.title="tor-relay" \
      org.opencontainers.image.description="Tor relay on Linuxserver.io Alpine base image" \
      org.opencontainers.image.authors="Nicolas Coutin <ilshidur@gmail.com>" \
      org.opencontainers.image.licenses="MIT"

ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_DATA_HOME="/config" \
XDG_CONFIG_HOME="/config"
ENV TZ America/Los_Angeles

RUN apk --no-cache add bash tzdata tor

EXPOSE 9001 9030

# TOR configuration through environment variables.
ENV RELAY_TYPE relay
ENV TOR_ORPort 9001
ENV TOR_DirPort 9030
ENV TOR_DataDirectory /data
ENV TOR_ContactInfo "Random Person nobody@tor.org"

# Copy the default configurations.
COPY torrc.bridge.default /config/torrc.bridge.default
COPY torrc.relay.default /config/torrc.relay.default
COPY torrc.exit.default /config/torrc.exit.default

COPY entrypoint.sh /entrypoint.sh
RUN chmod ugo+rx /entrypoint.sh

COPY /root /
VOLUME /data
