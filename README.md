# charts

Helm Charts for running a scalable StartupJS app

## Information

The `app` chart is currently designed to work specifically with `Google Cloud`.

## Installing Charts from this Repository

Add the Repository to Helm:

```sh
helm repo add startupjs https://startupjs.github.io/charts
```

### `app`

Install startupjs app:

```sh
helm install startupjs/app -v values.yaml
```

#### Sample values

```yaml
global:
  redisUrl: "redis://10.142.0.12:6379/14"
  mongoUrl: "mongodb://10.142.0.11:27017/myapp?replicaSet=rs1"
  staticIpName: "myapp"
server:
  replicas: 1
```

## Licence

MIT
