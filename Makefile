IMAGE_NAME := blog
PORT := 8000
RUN := docker run --rm -v $(CURDIR):/app -w /app $(IMAGE_NAME)

.PHONY: build build_blog clean rebuild serve reserve regenerate preview lint help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

build: ## Build the Docker image
	docker build -t $(IMAGE_NAME) .

build_blog: ## Build the blog content (dev settings)
	$(RUN) uv run fab build

clean: ## Remove generated output
	$(RUN) uv run fab clean

rebuild: ## Clean and rebuild the blog
	$(RUN) uv run fab rebuild

serve: ## Start local dev server on port 8000
	docker run --rm -v $(CURDIR):/app -w /app -p $(PORT):$(PORT) $(IMAGE_NAME) uv run fab serve

reserve: ## Build and serve in one step
	docker run --rm -v $(CURDIR):/app -w /app -p $(PORT):$(PORT) $(IMAGE_NAME) uv run fab reserve

regenerate: ## Watch for changes and auto-regenerate
	docker run --rm -v $(CURDIR):/app -w /app -p $(PORT):$(PORT) $(IMAGE_NAME) uv run fab regenerate

preview: ## Build with production settings
	$(RUN) uv run fab preview

lint: ## Run markdownlint on content
	$(RUN) mdl content/
