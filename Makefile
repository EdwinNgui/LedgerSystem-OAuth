.PHONY: all build run clean wait-for-app open-browser

# Default target: build images and start containers
all: build run wait-for-app open-browser

# Build Docker images based on docker-compose.yml
build:
	@if [ ! -f .env ]; then \
		echo "Error: .env file not found. Please create it with required environment variables."; \
		exit 1; \
	fi
	cd ledger-api && mvn clean package -DskipTests
	docker compose --env-file .env build

# Start containers in detached mode
run:
	@if [ ! -f .env ]; then \
		echo "Error: .env file not found. Please create it with required environment variables."; \
		exit 1; \
	fi
	docker compose --env-file .env up -d --remove-orphans

# Stop containers but keep data and images
clean:
	@if [ ! -f .env ]; then \
		echo "Error: .env file not found. Please create it with required environment variables."; \
		exit 1; \
	fi
	docker compose --env-file .env down --remove-orphans
	cd ledger-api && mvn clean

wait-for-app:
	@echo "Waiting for app to be ready..."
	@timeout=60; \
	while [ $$timeout -gt 0 ]; do \
		if curl -s http://localhost:8080/actuator/health > /dev/null; then \
			echo "App is ready!"; \
			exit 0; \
		fi; \
		echo "Waiting... ($$timeout seconds remaining)"; \
		sleep 2; \
		timeout=$$((timeout - 2)); \
	done; \
	echo "App failed to start within 60 seconds"; \
	exit 1

open-browser:
	@echo "Opening browser..."
	@xdg-open http://localhost:8080 || \
	open http://localhost:8080 || \
	start http://localhost:8080 || \
	echo "Could not open browser automatically. Please visit http://localhost:8080"
