# Learning Journal — Ledger System OAuth Project

### Microservice
- Handling specific business capability (managing finnancial ledger entries with secure OAuth access)
- Encapsulates it's own logic and data storage (Postgres DB)
- Well-defined API that exposes a clear boundary for other services to interact with


---

## Spring Boot
- Spring: Java Framework for applications with dependency injection, transaction management, and web app development
- Used [Spring Initializer] (https://start.spring.io/) to quickly configure settings

### 3 Types of Projects
1. Gradle - Groovy: Uses Domain Specific Language (DSL) using Groovy or Kotlin, best in large multi-module projects
2. Gradle - Kotlin: Runs on Java Virtual Machine (JVM) often for modern web apps
3. Maven: Build automation tool using XML configs, for ease of use

### File Structure of: ledger-api.src/main/java/com/example/ledger_api
1. config: Config classes like security setup, OAuth settings, and message broker configs
2. controller: Handles HTTP requests, maps URLs to methods, REST API; web logic layer
3. model: Entity classes like blueprints to business objects (and their data structure)
4. repository: Data access layer, interacts with DB, seperates DB logic from business logic
5. service: Business logic layer, core functionality like ledger processing, transaction validation, message brokers

## Docker
- Platform for containerization and running applications for concistent environments
- docker-compose.yml: Creates a PostgreSQL 15 Container exposed on port 5432 where data is on a named Docker volume
- We can quickly setup/deploy