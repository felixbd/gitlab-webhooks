# gitlab-webhooks

## `docker` setup via `nix-build` (currently broken ...)

```shell
nix-build docker.nix -o result
```

```shell
docker load -i ./result
```

```shell
docker images | grep gitlab-webhooks-server
```

```shell
docker run -it -v $(pwd)/app.py:/app.py -p 5000:5000 gitlab-webhooks-server:latest flask run --host=0.0.0.0
```

## `nix-shell` setup

```shell
nix-shell
```

```shell
flask run
```

## test via curl

```shell
curl -X POST -H "Content-Type: application/json" -d '{"object_kind": "push", "message": "Example commit message"}' http://localhost:5000/webhook
```
