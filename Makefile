# For building css, js files

FOLDER = public

CSS_FOLDER = $(FOLDER)/css
CSS_C = lessc
CSS_C_OPTS = --yui-compress
CSS_DEPS = $(CSS_FOLDER)/bootstrap.min.css
CSS_SRCS = $(CSS_FOLDER)/all-src.css

COFFEE_FOLDER = $(FOLDER)/js
COFFEE_C = coffee
COFFEE_C_OPTS = -c -o $(COFFEE_FOLDER)

JS_FOLDER = $(FOLDER)/js
JS_C = uglifyjs
JS_C_OPTS = -nc
JS_DEPS = $(JS_FOLDER)/jquery.min.js \
				$(JS_FOLDER)/bootstrap.min.js
JS_SRCS = $(JS_FOLDER)/all.min.js

CONCAT = cat

all: css coffee js

css: all-src.css all.css

coffee: all-src.js

js: all.min.js all.js

all-src.css:
	 $(CSS_C) $(CSS_C_OPTS) $(CSS_FOLDER)/all-src.less $(CSS_FOLDER)/all-src.css

all.css:
	 $(CONCAT) $(CSS_DEPS) $(CSS_SRCS) > $(CSS_FOLDER)/all.css

all-src.js:
	 $(COFFEE_C) $(COFFEE_C_OPTS) $(COFFEE_FOLDER)/all-src.coffee

all.min.js:
	 $(JS_C) $(JS_C_OPTS) $(JS_FOLDER)/all-src.js > $(JS_FOLDER)/all.min.js

all.js:
	 $(CONCAT) $(JS_DEPS) $(JS_SRCS) > $(JS_FOLDER)/all.js

clean:
	-rm -f $(CSS_FOLDER)/all-src.css $(CSS_FOLDER)/all.css \
		$(JS_FOLDER)/all-src.js $(JS_FOLDER)/all.min.js $(JS_FOLDER)/all.js

