# Makefile for building and running the project with Docker Compose
# Build and run interactively (attached)
server-compose-interactive:
	@echo "Building and starting docker-compose (interactive)..."
	docker compose up --build

# Build and run in detached mode
server-compose-detached:
	@echo "Building and starting docker-compose (detached)..."
	docker compose up --build -d

# Build only
build:
	@echo "Building docker-compose images..."
	docker compose build

# Stop and remove containers, networks
down:
	@echo "Stopping and removing docker-compose services..."
	docker compose down

# Show logs (follow)
logs:
	@echo "Tailing docker-compose logs (press Ctrl-C to exit)"
	docker compose logs -f
