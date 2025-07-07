# 💰 Ledger System with OAuth 2.0

A comprehensive FinTech ledger system with full OAuth 2.0 authorization server implementation.

## 🎯 Project Goals / Learning Outcomes

| Goal # | Concept Learned | Feature or Task Implemented |
|--------|-----------------|------------------------------|
| 1️⃣ | **Authentication with OAuth 2.0** | Secure routes, token flow |
| 2️⃣ | **JWT tokens** | Role-based access control |
| 3️⃣ | **Double-entry bookkeeping** | Ledger API with balances |
| 4️⃣ | **Idempotent APIs** | Prevent duplicate txns |
| 5️⃣ | **Solace PubSub+** | Publish-subscribe messaging |
| 6️⃣ | **Microservices** | Ledger / Balance / Audit |
| 7️⃣ | **PostgreSQL** | ACID-compliant data storage |
| 8️⃣ | **Docker & Compose** | Deploy full system locally |
| 9️⃣ | **React + Tailwind** *(optional)* | Real-time UI dashboard |
| 🔟 | **CI/CD and Logs** *(optional)* | For monitoring and health |

## 🧱 Tech Stack

| Layer | Tools / Tech |
|-------|--------------|
| **Backend API** | Spring Boot OR FastAPI / Node.js |
| **Messaging** | Solace PubSub+ (Cloud or Docker broker) |
| **Auth** | OAuth 2.0 + JWT (Auth0 / Keycloak / DIY) |
| **Database** | PostgreSQL |
| **Frontend UI** | React + TailwindCSS *(Optional)* |
| **Infrastructure** | Docker + Docker Compose |

## ✨ Features

- **OAuth 2.0 Authorization Server** with JWT tokens
- **OpenID Connect 1.0** support
- **Multiple OAuth flows**: Authorization Code, Client Credentials, Refresh Token
- **Role-based access control** (USER, ADMIN roles)
- **Protected API endpoints** with proper authentication
- **Docker support** with PostgreSQL database
- **Comprehensive testing** and documentation

## Quick Start

### Prerequisites

- Java 21
- Docker and Docker Compose
- Maven

### Using Docker (Recommended)

1. **Clone and setup**:
   ```bash
   git clone <repository-url>
   cd LedgerSystem-OAuth
   ```

2. **Create environment file**:
   ```bash
   cp .env.example .env
   # Edit .env with your database credentials
   ```

3. **Start the demo** (easiest way):
   ```bash
   ./start-demo.sh
   ```
   
   This will:
   - Build and start the application
   - Open your browser to the demo page
   - Show you all the OAuth 2.0 features

4. **Or build and run manually**:
   ```bash
   make all
   # Then open http://localhost:8080 in your browser
   ```

5. **Test the implementation**:
   ```bash
   ./ledger-api/test-oauth2.sh
   ```

### Manual Setup

1. **Build the application**:
   ```bash
   cd ledger-api
   mvn clean package
   ```

2. **Run the application**:
   ```bash
   mvn spring-boot:run
   ```

## OAuth 2.0 Implementation

### Available Endpoints

- **Authorization**: `GET /oauth2/authorize`
- **Token**: `POST /oauth2/token`
- **User Info**: `GET /api/profile`
- **JWK Set**: `GET /.well-known/jwks.json`
- **OpenID Config**: `GET /.well-known/openid_configuration`

### Pre-configured Users

- **Username**: `user`, **Password**: `password`, **Roles**: USER
- **Username**: `admin`, **Password**: `admin`, **Roles**: USER, ADMIN

### Pre-configured Clients

- **Client ID**: `ledger-client`, **Secret**: `ledger-secret`
- **Client ID**: `postman-client`, **Secret**: `postman-secret`

### Testing OAuth 2.0

#### Client Credentials Flow
```bash
curl -X POST "http://localhost:8080/oauth2/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Authorization: Basic bGVkZ2VyLWNsaWVudDpsZWRnZXItc2VjcmV0" \
  -d "grant_type=client_credentials&scope=read write"
```

#### Using Access Token
```bash
curl -X GET "http://localhost:8080/api/profile" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

## API Endpoints

### Public Endpoints
- `GET /api/public/health` - Health check (no authentication required)

### Protected Endpoints
- `GET /api/ledger/balance` - Get user balance (requires USER role)
- `POST /api/ledger/transaction` - Create transaction (requires USER role)
- `GET /api/admin/users` - List users (requires ADMIN role)
- `GET /api/profile` - Get user profile (requires authentication)

## 📚 Documentation

- [OAuth 2.0 Implementation Guide](ledger-api/OAUTH2_GUIDE.md) - Comprehensive OAuth 2.0 documentation
- [Commands Reference](Commands.md) - Quick reference for common commands

## Architecture

The application uses:
- **Spring Boot 3.5.0** with Spring Security
- **Spring Security OAuth2 Authorization Server** for OAuth 2.0 implementation
- **JWT tokens** for stateless authentication
- **PostgreSQL** for data persistence (when enabled)
- **Docker** for containerization

## Security Features

- JWT token validation with RSA signatures
- Role-based access control with `@PreAuthorize` annotations
- Secure headers and CSRF protection
- Configurable token lifetimes
- OpenID Connect 1.0 compliance

## Development

### Project Structure
```
ledger-api/
├── src/main/java/com/example/ledger_api/
│   ├── config/
│   │   ├── OAuth2AuthorizationServerConfig.java
│   │   └── ClientRegistrationConfig.java
│   ├── controller/
│   │   └── LedgerController.java
│   └── LedgerApiApplication.java
├── src/main/resources/
│   └── application.yml
├── test-oauth2.sh
└── OAUTH2_GUIDE.md
```

### Building
```bash
cd ledger-api
mvn clean package
```

### Testing
```bash
# Run OAuth 2.0 tests
./test-oauth2.sh

# Run unit tests
mvn test
```

## 🐳 Docker Commands

See [Commands.md](Commands.md) for all available commands.

## Troubleshooting

### Common Issues

1. **Port conflicts**: Ensure port 8080 is available
2. **Database connection**: Check PostgreSQL container is running
3. **OAuth errors**: Verify client credentials and redirect URIs
4. **Token expiration**: Use refresh tokens to get new access tokens

### Debug Logging

Enable debug logging in `application.yml`:
```yaml
logging:
  level:
    org.springframework.security: DEBUG
    org.springframework.security.oauth2: DEBUG
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is licensed under the MIT License.
