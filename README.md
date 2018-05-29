# docker-proxy

This server proxy all GET routes to the docker.sock and deny all other HTTP method. 

## How to build

`docker build -t docker-proxy .`

### Build args

| Arg         | Default |
| ----------- | ------- |
| SERVER_PORT | 8080    |

`docker build --build-arg SERVER_PORT=8888 -t docker-proxy .`

## How to run

`docker run -d --rm -v /var/run/docker.sock:/var/run/docker.sock:ro -p 8080:8080 docker-proxy`

## Examples

| URL                                                                     | Description                  | Result     |
| ----------------------------------------------------------------------- | ---------------------------- | ---------- |
| `curl -g -X GET http://localhost:8080/v1.33/containers/json?filters={}` | Returns a list of containers | :thumbsup: |
| `curl -g -X POST http://localhost:8080/v1.33/containers/{id}/stop`      | Stop a container             | :boom:     |

Ref: https://docs.docker.com/engine/api/v1.33/
