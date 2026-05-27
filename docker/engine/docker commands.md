### To build the docker image project's root folder:
```bash
docker build -f docker/engine/Dockerfile -t seyoawe-engine:1.0.0 .
```

### To run the docker image project's root folder:
```bash
docker run -d \
    -p 8080:8080 \
    -p 9000:9000 \
    -v ./app_data/logs:/app/logs \
    -v ./app_data/lifetimes:/app/lifetimes \
    -v ./engine/modules:/app/modules/ \
    -v ./engine/workflows:/app/workflows \
    --name seyoawe-engine \
    seyoawe-engine:1.0.0
```