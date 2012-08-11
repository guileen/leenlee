# For building css, js files

# folders
FOLDER = public
SRC = src
LESS_SRC = $(SRC)/css
COFFEE_SRC = $(SRC)/js

DEST = dest
LESS_DEST = $(DEST)/css
COFFEE_DEST = $(DEST)/js

# less, css
LESS_FILES = $(LESS_SRC)/all-src.less
LESS_ALL = $(LESS_DEST)/all-src.less
LESS_TARGET_FILE = $(LESS_DEST)/all-src.css

CSS_FOLDER = $(FOLDER)/css
CSS_FILES = $(CSS_FOLDER)/bootstrap.min.css \
					 $(CSS_FOLDER)/nanoscroller.css \
					 $(LESS_TARGET_FILE)
CSS_ALL = $(CSS_FOLDER)/all.css
CSS_ALL_MIN = $(CSS_FOLDER)/all.min.css

# coffee, js
COFFEE_FILES = $(COFFEE_SRC)/base.coffee \
			   $(COFFEE_SRC)/init.coffee \
			   $(COFFEE_SRC)/page-*.coffee \
			   $(COFFEE_SRC)/main.coffee
COFFEE_ALL = $(COFFEE_DEST)/all-src.coffee
# all-src.coffee -> all-src.js must be same filename
COFFEE_TARGET_FILE = $(COFFEE_DEST)/all-src.js 

JS_FOLDER = $(FOLDER)/js
JS_DEPS = $(JS_FOLDER)/jquery.min.js \
				$(JS_FOLDER)/jquery.validate.min.js \
				$(JS_FOLDER)/bootstrap.min.js \
				$(JS_FOLDER)/jquery.nanoscroller.js \
				$(COFFEE_TARGET_FILE)
JS_ALL = $(JS_FOLDER)/all.js
JS_ALL_MIN = $(JS_FOLDER)/all.min.js

# compiler and options
COFFEE_C = coffee
COFFEE_C_OPTS = -c -o $(COFFEE_DEST)

CSS_C = lessc
CSS_C_OPTS = --yui-compress

JS_C = uglifyjs
JS_C_OPTS = -nc

CONCAT = cat
MKDIR = mkdir -p

all: css js

css: $(CSS_ALL)

coffee: $(COFFEE_TARGET_FILE)

js: $(JS_ALL_MIN)

$(LESS_ALL): $(LESS_FILES)
	$(MKDIR) $(LESS_DEST)
	$(CONCAT) $(LESS_FILES) > $(LESS_ALL)

$(LESS_TARGET_FILE): $(LESS_ALL)
	$(CSS_C) $(CSS_C_OPTS) $(LESS_ALL) $(LESS_TARGET_FILE)

$(CSS_ALL): $(LESS_TARGET_FILE)
	$(CONCAT) $(CSS_FILES) > $(CSS_ALL)

$(COFFEE_ALL): $(COFFEE_FILES)
	$(MKDIR) $(COFFEE_DEST)
	$(CONCAT) $(COFFEE_FILES) > $(COFFEE_ALL)

$(COFFEE_TARGET_FILE): $(COFFEE_ALL)
	$(COFFEE_C) $(COFFEE_C_OPTS) $(COFFEE_ALL)

$(JS_ALL_MIN): $(JS_ALL)
	$(JS_C) $(JS_C_OPTS) $(JS_ALL) > $(JS_ALL_MIN)

$(JS_ALL): $(JS_DEPS)
	$(CONCAT) $(JS_DEPS) $(JS_SRCS) > $(JS_ALL)

clean:
	-rm -rf $(JS_ALL) $(JS_ALL_MIN) $(CSS_ALL) $(CSS_ALL_MIN) $(LESS_ALL) $(LESS_TARGET_FILE) $(COFFEE_ALL) $(COFFEE_TARGET_FILE)
