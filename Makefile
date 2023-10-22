.PHONY: serve
serve:
	hugo serve --buildDrafts

.PHONY: build
build:
	hugo --buildDrafts --minify
	