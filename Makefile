.PHONY: all build up down logs clean

# Default target: build images and start containers
all: build up

# Build Docker images based on docker-compose.yml
build:
	docker-compose build

# Start containers in detached mode
up:
	docker-compose up -d

# Stop containers but keep data and images
down:
	docker-compose down

# Follow logs for all services
logs:
	docker-compose logs -f

# Remove containers, networks, images, and volumes (clean slate)
clean:
	docker-compose down -v --rmi all --remove-orphans
