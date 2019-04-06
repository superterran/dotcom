.DEFAULT_GOAL := help
.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## one complete build process
	npm install
	mkdir -p _build
	cp -rf node_modules/casper/* _build/

	cp _config.yml _build/
	cd _build/ && npm install
	cd _build/ && bundle install
	cd _build/ && bundle exec jekyll build

serve: build ## cleans the directory structure
	make build
	cd _build/ && bundle exec jekyll serve


# rm -rf assets/images/, 
