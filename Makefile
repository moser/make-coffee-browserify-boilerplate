COFFEE=$(shell find src -name '*.coffee')
JADE=$(shell find src -name '*.jade')
LESS=$(shell find src -name '*.less')
JS=$(COFFEE:%.coffee=%.js)

build: build/app.js build/app.css build/index.html

build/index.html: src/index.html
	cp src/index.html build/

build/app.js: src/bundle.js
	mkdir -p build
	cp src/bundle.js build/app.js

build/app.css: $(LESS)
	mkdir -p build
	cat $(LESS) |	node_modules/less/bin/lessc - > build/app.css

src/bundle.js: $(JS) src/templates.js
	node_modules/browserify/bin/cmd.js src/main.js -o src/bundle.js

%.js: %.coffee
	node_modules/coffee-script/bin/coffee -c $< 

src/templates.js: $(JADE)
	node_modules/templatizer/bin/cli -d src/templates -o src/templates.js

clean:
	rm src/*.js
	rm src/**/*.js
	rm -r build/
