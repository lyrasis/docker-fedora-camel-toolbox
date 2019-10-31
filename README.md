# Docker Fedora Camel Toolbox

Run Fedora Camel Toolbox in Karaf using docker.

```bash
docker build -t fedora-camel-toolbox .
docker run --name toolbox -d -p 8181:8181 fedora-camel-toolbox:latest
docker logs -f toolbox
```
