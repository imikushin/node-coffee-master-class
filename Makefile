ifeq ($(shell uname),Darwin)
	MD5 = md5
	WATCHER   = fswatch ./src/ 'make build'
else
	MD5 = md5sum
	WATCHER   = while true; do inotifywait -m ./src/ | make build; done;
endif

COFFEE    = $(shell find src -type f -name "*.coffee" | sort)
STATIC    = $(shell find src/static -type f | sort)
TEMPLATES = $(shell find src/templates -type f -name "*.eco" | sort)

build: $(addprefix build/, $(COFFEE:src/%.coffee=%.js) $(STATIC:src/%=%))

build/%.js: src/%.coffee
	@mkdir -p $(@D)
	./node_modules/.bin/coffee -pcb $< > $@

build/%: src/%
	@mkdir -p $(@D)
	@cp $< $@

run: build
	@./node_modules/.bin/supervisor build/app.js

clean:
	@rm -rf build
	@echo 'done'

watch: build
	@echo 'Start watching $(shell pwd)'
	@echo '***'
	@echo ''
	@$(WATCHER)