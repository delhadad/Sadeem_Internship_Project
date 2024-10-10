.PHONY: run install build clean help


help:  ## Shows the available commands
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

run: ## Runs the frontend (same as npm run dev)
	@echo "Running the frontend application..."
	npm run dev

install: ## Installs all dependencies (same as npm install)
	@echo " Installing dependencies..."
	npm install

build: ## Builds the project for production (same as npm run build)
	@echo "Building the frontend application..."
	npm run build

clean: ## Cleans the project (removes node_modules and dist)
	@echo "Cleaning the project..."
	rm -rf node_modules
	rm -rf dist
