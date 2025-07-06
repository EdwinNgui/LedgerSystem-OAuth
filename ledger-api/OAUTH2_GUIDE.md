# OAuth 2.0 Implementation Guide

This document provides a comprehensive guide to the OAuth 2.0 implementation in the Ledger API.

## Overview

The application implements a full OAuth 2.0 Authorization Server with the following features:
- Authorization Code Flow
- Client Credentials Flow
- Refresh Token Flow
- OpenID Connect 1.0 support
- JWT token handling
- Role-based access control

## Available Endpoints

### OAuth 2.0 Authorization Server Endpoints

1. **Authorization Endpoint**: `GET /oauth2/authorize`
2. **Token Endpoint**: `POST /oauth2/token`
3. **Token Introspection**: `POST /oauth2/introspect`
4. **Token Revocation**: `POST /oauth2/revoke`
5. **JWK Set**: `GET /.well-known/jwks.json`
6. **OpenID Connect Discovery**: `GET /.well-known/openid_configuration`

### Protected API Endpoints

1. **Public Health Check**: `GET /api/public/health`
2. **User Balance**: `GET /api/ledger/balance` (requires USER role)
3. **Create Transaction**: `POST /api/ledger/transaction` (requires USER role)
4. **Admin Users**: `GET /api/admin/users` (requires ADMIN role)
5. **User Profile**: `GET /api/profile` (requires authentication)

## Pre-configured Users

- **Username**: `user`, **Password**: `password`, **Roles**: USER
- **Username**: `admin`, **Password**: `admin`, **Roles**: USER, ADMIN

## Pre-configured Clients

### Ledger Client
- **Client ID**: `ledger-client`
- **Client Secret**: `ledger-secret`
- **Redirect URIs**:
  - `http://127.0.0.1:8080/login/oauth2/code/ledger-client`
  - `http://127.0.0.1:3000/callback`
  - `http://localhost:3000/callback`
- **Scopes**: `openid`, `profile`, `read`, `write`, `admin`
- **Grant Types**: Authorization Code, Refresh Token, Client Credentials

### Postman Client
- **Client ID**: `postman-client`
- **Client Secret**: `postman-secret`
- **Redirect URI**: `https://oauth.pstmn.io/v1/callback`
- **Scopes**: `openid`, `profile`, `read`, `write`
- **Grant Types**: Authorization Code, Refresh Token, Client Credentials

## Authorization Code Flow Example

### Step 1: Authorization Request
```
GET /oauth2/authorize?
  response_type=code&
  client_id=ledger-client&
  redirect_uri=http://127.0.0.1:3000/callback&
  scope=openid profile read write&
  state=random_state_string
```

### Step 2: Token Exchange
```
POST /oauth2/token
Content-Type: application/x-www-form-urlencoded
Authorization: Basic bGVkZ2VyLWNsaWVudDpsZWRnZXItc2VjcmV0

grant_type=authorization_code&
code=AUTHORIZATION_CODE&
redirect_uri=http://127.0.0.1:3000/callback
```

### Step 3: Use Access Token
```
GET /api/ledger/balance
Authorization: Bearer ACCESS_TOKEN
```

## Client Credentials Flow Example

```
POST /oauth2/token
Content-Type: application/x-www-form-urlencoded
Authorization: Basic bGVkZ2VyLWNsaWVudDpsZWRnZXItc2VjcmV0

grant_type=client_credentials&
scope=read write
```

## Refresh Token Flow Example

```
POST /oauth2/token
Content-Type: application/x-www-form-urlencoded
Authorization: Basic bGVkZ2VyLWNsaWVudDpsZWRnZXItc2VjcmV0

grant_type=refresh_token&
refresh_token=REFRESH_TOKEN
```

## Testing with cURL

### 1. Get Authorization Code
```bash
curl -X GET "http://localhost:8080/oauth2/authorize?response_type=code&client_id=ledger-client&redirect_uri=http://127.0.0.1:3000/callback&scope=openid profile read write&state=test123"
```

### 2. Exchange Code for Token
```bash
curl -X POST "http://localhost:8080/oauth2/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Authorization: Basic bGVkZ2VyLWNsaWVudDpsZWRnZXItc2VjcmV0" \
  -d "grant_type=authorization_code&code=AUTHORIZATION_CODE&redirect_uri=http://127.0.0.1:3000/callback"
```

### 3. Use Access Token
```bash
curl -X GET "http://localhost:8080/api/ledger/balance" \
  -H "Authorization: Bearer ACCESS_TOKEN"
```

### 4. Client Credentials Flow
```bash
curl -X POST "http://localhost:8080/oauth2/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Authorization: Basic bGVkZ2VyLWNsaWVudDpsZWRnZXItc2VjcmV0" \
  -d "grant_type=client_credentials&scope=read write"
```

## Testing with Postman

1. Import the OAuth 2.0 collection
2. Configure the authorization settings:
   - **Type**: OAuth 2.0
   - **Grant Type**: Authorization Code
   - **Callback URL**: `https://oauth.pstmn.io/v1/callback`
   - **Auth URL**: `http://localhost:8080/oauth2/authorize`
   - **Access Token URL**: `http://localhost:8080/oauth2/token`
   - **Client ID**: `postman-client`
   - **Client Secret**: `postman-secret`
   - **Scope**: `openid profile read write`

## JWT Token Structure

The JWT tokens contain the following claims:
- `sub`: Subject (user ID)
- `iss`: Issuer (http://localhost:8080)
- `aud`: Audience (client ID)
- `exp`: Expiration time
- `iat`: Issued at time
- `scope`: Granted scopes
- `roles`: User roles (for authorization)

## Security Features

1. **JWT Token Validation**: All tokens are validated using RSA signatures
2. **Role-based Access Control**: Endpoints are protected using `@PreAuthorize` annotations
3. **CSRF Protection**: Disabled for API endpoints
4. **Secure Headers**: Spring Security default security headers
5. **Token Expiration**: Configurable token lifetimes

## Configuration

The OAuth 2.0 server is configured in:
- `OAuth2AuthorizationServerConfig.java`: Main authorization server configuration
- `ClientRegistrationConfig.java`: Client registration configuration
- `application.yml`: Application properties

## Docker Deployment

The application is configured to work with Docker using the provided `docker-compose.yml` and `Makefile`:

```bash
# Build and start all services
make all

# Or step by step
make build
make run
```

## Troubleshooting

### Common Issues

1. **Invalid Client**: Ensure client ID and secret match the configuration
2. **Invalid Redirect URI**: Check that the redirect URI is registered for the client
3. **Invalid Scope**: Verify that the requested scopes are configured for the client
4. **Token Expired**: Use refresh token to get a new access token

### Debug Logging

Enable debug logging by setting in `application.yml`:
```yaml
logging:
  level:
    org.springframework.security: DEBUG
    org.springframework.security.oauth2: DEBUG
    org.springframework.security.oauth2.server: DEBUG
```

## Next Steps

1. **Database Integration**: Replace in-memory storage with database persistence
2. **User Management**: Implement user registration and management
3. **Audit Logging**: Add comprehensive audit trails
4. **Rate Limiting**: Implement API rate limiting
5. **Monitoring**: Add metrics and monitoring 