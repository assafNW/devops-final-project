### To build the docker image from project's root folder:
```bash
docker build -f docker/cli/Dockerfile -t seyoawe-cli:1.0.0 .
```

### To run the docker image project's root folder:
```bash
docker run -d \
    -p 8081:8081 \
    -v ./engine/modules:/home/sawectl/modules/ \
    -v ./engine/workflows:/home/sawectl/workflows \
    --name seyoawe-cli \
    seyoawe-cli:1.0.0
```