FROM alpine:latest
LABEL maintainer "Carlos Rodriguez <comercial@rodriguezst.es>" architecture="ARM32v7/armhf"

ARG plugins=http.cors,http.jwt,http.login,http.realip

RUN apk add --no-cache tar curl libcap && \
    curl --silent --show-error --fail --location --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/arm7?plugins=${plugins}&license=personal&telemetry=off" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy && \
    setcap cap_net_bind_service=+ep `readlink -f /usr/bin/caddy` && \
    /usr/bin/caddy -version

EXPOSE 80 443 2015
VOLUME /srv
VOLUME /root/.caddy
WORKDIR /srv

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/root/.caddy/Caddyfile"]
