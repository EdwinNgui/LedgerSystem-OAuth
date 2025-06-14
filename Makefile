.PHONY: all build run clean wait-for-app open-browser

# Default target: build images and start containers
all: build run wait-for-app open-browser

# Build Docker images based on docker-compose.yml
build:
	cd ledger-api && mvn clean package -DskipTests

# Start containers in detached mode
run:
	docker compose up -d

# Stop containers but keep data and images
clean:
	docker compose down
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
