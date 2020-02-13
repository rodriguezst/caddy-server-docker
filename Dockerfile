FROM alpine:latest as downloader
LABEL maintainer "Carlos Rodriguez <comercial@rodriguezst.es>" architecture="x86_64"

ARG plugins=http.cors,http.jwt,http.login,http.realip,http.cgi

RUN apk --update --no-cache add \ 
    ca-certificates tar curl libcap && \
    curl --silent --show-error --fail --location --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?plugins=${plugins}&license=personal&telemetry=off" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy

FROM scratch

COPY --from=downloader /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=downloader /usr/bin/caddy /usr/bin/caddy

EXPOSE 80 443 2015
VOLUME /srv
VOLUME /config

WORKDIR /config
ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/config/Caddyfile", "--agree"]
