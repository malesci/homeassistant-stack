# Home Assistant Stack with Docker Compose

This is a docker compose to create an Home Assistant stack with:

- Home Assistant Core
- Eclipse Mosquitto MQTT broker
- Dehydrated for DuckDns
- Portainer

## Installation steps

Make a copy of `mosquitto/config/mosquitto.example.conf` file as `mosquitto/config/mosquitto.conf`

Make a copy of `dehydrated-duckdns/data/options.example.json` file as `data/options.json`

Make a copy of `.env.dist` file as `.env` under main directory and edit its content. E.g.:

```bash
HOMEASSISTANT_CONFIGDIR=/home/user/docker-compose/homeassistant
PORTAINER_PORT=9000
```

## Running stack

I suggest to run containers one by one so...

Run in foreground with...

`docker-compose up <container-name>`

Run in background with...

`docker-compose up <container-name> -d`