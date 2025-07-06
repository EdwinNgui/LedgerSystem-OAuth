## Spring Boot

### Spring Boot Clean Install
mvn clean install

### Run the Spring Boot App
cd ledger-api
<!-- ./mvnw spring-boot:run -->
mvn spring-boot:run

Note: Visit ```http://localhost:8080/h2-console```
HELP: sdk use java 21.0.2-tem

## OAuth 2.0 Testing

### Web Interface (Recommended)
```bash
# Start the application
make all

# Open in browser
http://localhost:8080
```

The web interface provides:
- 🔐 OAuth 2.0 authentication demo
- 👤 User information display
- 🧪 API endpoint testing
- 📊 Real-time authentication status

### Test OAuth 2.0 Implementation
```bash
# Run the test script
./ledger-api/test-oauth2.sh

# Manual testing with curl
curl -X GET "http://localhost:8080/api/public/health"
curl -X GET "http://localhost:8080/.well-known/openid_configuration"
```

### OAuth 2.0 Endpoints
- Authorization: `GET /oauth2/authorize`
- Token: `POST /oauth2/token`
- User Info: `GET /api/profile`
- JWK Set: `GET /.well-known/jwks.json`
- OpenID Config: `GET /.well-known/openid_configuration`

### Pre-configured Users
- Username: `user`, Password: `password`, Roles: USER
- Username: `admin`, Password: `admin`, Roles: USER, ADMIN

### Pre-configured Clients
- Client ID: `ledger-client`, Secret: `ledger-secret`
- Client ID: `postman-client`, Secret: `postman-secret`

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