# Ledger System Commands

## 🚀 Quick Start

```bash
# Start everything (recommended)
./start-demo.sh

# Or manually
make all
```

Then open: **http://localhost:8080**

## 🔧 Development Commands

### Spring Boot
```bash
cd ledger-api
mvn clean install
mvn spring-boot:run
```

### Docker
```bash
make all          # Build and start
make build        # Build only
make run          # Start services
make clean        # Stop and remove
```

## 🧪 Testing

### Web Interface
- Open **http://localhost:8080** in your browser
- Test OAuth flows and API endpoints

### Command Line
```bash
./ledger-api/test-oauth2.sh
curl -X GET "http://localhost:8080/api/public/health"
```

## 👥 Demo Accounts

| Username | Password | Role |
|----------|----------|------|
| `user`   | `password` | USER |
| `admin`  | `admin`     | USER, ADMIN |

## 🔐 OAuth Clients

| Client ID | Secret | Use |
|-----------|--------|-----|
| `ledger-client` | `ledger-secret` | Web App |
| `postman-client` | `postman-secret` | API Testing |

## 📍 Key Endpoints

- **Demo Page**: `http://localhost:8080`
- **Health Check**: `GET /api/public/health`
- **OAuth Auth**: `GET /oauth2/authorize`
- **OAuth Token**: `POST /oauth2/token`
- **User Profile**: `GET /api/profile`
- **JWK Set**: `GET /.well-known/jwks.json`