# caddy-server-docker

Caddy (http://caddyserver.com) docker image built on top of alpine:latest

Place your Caddyfile in $HOME/.caddy/Caddyfile and run the following command:

```bash
docker run -d -v $HOME/.caddy:/root/.caddy -v $HOME/www:/srv -p 80:80 -p 443:443 rodriguezst/caddy:armhf
```

NOTE: A volume is mounted at $HOME/www to store webserver contents (HTML,CSS...)
