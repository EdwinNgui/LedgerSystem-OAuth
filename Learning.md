# Learning Journal — Ledger System OAuth Project

---

# Structure

## 3 Types of Projects
1. Gradle - Groovy: Uses Domain Specific Language (DSL) using Groovy or Kotlin, best in large multi-module projects
2. Gradle - Kotlin: Runs on Java Virtual Machine (JVM) often for modern web apps
3. Maven: Build automation tool using XML configs, for ease of use

## File Structure of: ledger-api.src/main/java/com/example/ledger_api
1. config: Config classes like security setup, OAuth settings, and message broker configs
2. controller: Handles HTTP requests, maps URLs to methods, REST API; web logic layer
3. model: Entity classes like blueprints to business objects (and their data structure)
4. repository: Data access layer, interacts with DB, seperates DB logic from business logic
5. service: Business logic layer, core functionality like ledger processing, transaction validation, message brokers

## Security
- Use env files to keep database and other program credentials abstracted from the core functionality features

---

# Concepts

## Microservice
- Handling specific business capability (managing finnancial ledger entries with secure OAuth access)
- Encapsulates it's own logic and data storage (Postgres DB)
- Well-defined API that exposes a clear boundary for other services to interact with

### Authentication Implementation
- LedgerApiApplication.java (main application class): Entry point for Spring Boot app
- config/
- - OAuth2AuthorizationServerConfig.java: Sets up endpoints, logins
- - ClientRegistrationConfig.java: Registers client (client ID, allowed redirect URIs)
- controller/
- - LedgerController.java: Defines API endpoints in ledger system (e.g. /api/public/health) or ones for specific roles
- - WebController.java: Serves main web page
- - CustomErrorController.java: Handles errors with error page
- model/ => Maps database tables to Java objects
- repository/ => Defines interface for database access


---

# Technologies

## Spring Boot
- Spring: Java Framework for applications with dependency injection, transaction management, and web app development
- Used [Spring Initializer] (https://start.spring.io/) to quickly configure settings

## Docker
- Platform for containerization and running applications for concistent environments
- docker-compose.yml: Creates a PostgreSQL 15 Container exposed on port 5432 where data is on a named Docker volume
- We can quickly setup/deploy

## OAuth 2.0
- User is the Resource Owner
- PhotoAlbum is like the Resource Server that stores our photos
- PrintMagic is an application Client that wants to access our Resource Server
- OAuth2 is the authorization server that will validate the Resource Key

### Workflow
| # | From | Action | To |
| --- | -----| ------ | ---|
| 1 | User | Print Photos | Print Magic |
| 2 | PrintMagic | Authorize with #clientId, #scope | OAuth2 |
| 3 | OAuth2 | "Request Permission" Dialog | User |
| 4 | User | Request Approved | OAuth2 |
| 5 | OAuth2 | Permissions Granted with #authorizationCode | PrintMagic |
| 6 | PrintMagic | Fetch access token with #authoriationCode, #clientid, #clientsecret | OAuth2 |
| 7 | OAuth2 | Gives token | PrintMagic |
| 8 | PrintMagic | Fetch photos | PhotoAlbum |
| 9 | PhotoAlbum | Returns photos | PrintMagic |