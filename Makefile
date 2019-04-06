.DEFAULT_GOAL := help
.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

compile: #run the compilation steps only
	npm install
	mkdir -p _build
	cp -rf node_modules/casper/* _build/

	make overlay

	cd _build/ && npm install
	cd _build/ && bundle install
build: compile ## one complete build process
	cd _build/ && bundle exec jekyll build

serve: compile ## serves on the default port, 4000 
	cd _build/ && bundle exec jekyll serve

overlay: ## cleans out the _build directory and adds our files in
	cp _config.yml _build/

	cp -rf theme/* _build/

	rm _build/_posts/*
	cp _posts/* _build/_posts/

	mkdir -p _build/projects/
	cp -rf projects/* _build/projects/

	cp -rf assets/* _build/assets/

	rm -rf _build/about/
	cp _content/* _build/
