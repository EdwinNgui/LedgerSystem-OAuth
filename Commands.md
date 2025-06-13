## Spring Boot

### Spring Boot Clean Install
mvn clean install

### Run the Spring Boot App
cd ledger-api
<!-- ./mvnw spring-boot:run -->
mvn spring-boot:run

Note: Visit ```http://localhost:8080/h2-console```
HELP: sdk use java 21.0.2-tem

## Docker
- Start Docker daemon: sudo systemctl start docker
- Start Docker service: sudo systemctl enable docker
- Check Docker service status: sudo systemctl status docker
- Check Docker working on system (without sudo): docker run hello-world
- Run Docker container on exposed port: docker run -p 8080:8080 --network="host" ledger-api

## Makefile (streamlining docker)
- Start Containers: Make up
- Stop and remove containers: Make down
- Rebuild images: Make build
- `make all` = `make build` + `make up` = `docker-compose build` + `docker-compose up -d`