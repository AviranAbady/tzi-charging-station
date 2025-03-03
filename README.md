# Dockerized OCPP 2 EVerest charging station

Ready to go OCPP charging station based on `everest-core`.

Docker compose configuration that packages and runs

* EVerest charging station
* Nodered
* Mosquitto MQTT broker

### Run
Clone the project the a directory of your choosing, with docker installed run

```
docker compose up
```

http://localhost:1880/ui/ - Charging station ui

http://localhost:1880/ - Configuration

First time build will take a few minutes to complete, due to compile time of the codebase.

## License

[MIT](https://choosealicense.com/licenses/mit/)

## Authors

[tzi.app](https://www.tzi.app)
