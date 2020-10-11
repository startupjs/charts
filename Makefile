SHELL := /bin/bash

-include .env
export

define n


endef

ifeq ($(CR_TOKEN),)
$(error "$nERROR!!! CR_TOKEN env var must be set.$nGo here to generate: https://github.com/settings/tokens.$nThen create .env file with the following content:$nCR_TOKEN=<token>$n$n")
endif

.PHONY: publish
publish:
	CHART=server $(MAKE) _single && \
	CHART=app $(MAKE) _single

.PHONY: _single
_single:
	helm package --dependency-update charts/$(CHART) --destination .deploy && \
	[[ $$(cr upload -o startupjs -r charts -p .deploy 2>&1) =~ "already_exists" ]] && \
	git checkout gh-pages && \
	cr index -i ./index.yaml -c https://startupjs.github.io/charts -p .deploy -o startupjs -r charts && \
	git add index.yaml && \
	git commit -m 'release' && \
	git push origin gh-pages && \
	git checkout main && \
	echo "> Uploaded new version of $(CHART)" || \
	git checkout main
