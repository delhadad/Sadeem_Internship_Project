.PHONY: run build test clean help

# Default target
help: ## Shows the available commands
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

run: build ## Builds the Rust project in release mode and runs the executable
	@echo "Running the Rust project..."
	./target/release/$(PROJECT_NAME)

build: ## Builds the Rust project in release mode
	@echo "Building the Rust project in release mode..."
	cargo build --release

test: ## Runs the Rust tests
	@echo "Running tests..."
	cargo test

clean: ## Cleans the Rust project
	@echo "Cleaning the project..."
	cargo clean
