mustache=node_modules/.bin/mustache
templates=$(wildcard **/*.mustache.html)
partials=$(wildcard partials/*)
targets=logo.png $(templates:.mustache.html=.html)

all: $(targets)

%.html: %.mustache.html $(partials) tidy.config | $(mustache)
	$(mustache) $(foreach partial,$(partials),-p $(partial)) view.json $< | tidy -config ./tidy.config > $@

%.png: %.svg
	convert $< $@

$(mustache):
	npm ci

.PHONY: clean

clean:
	rm -f $(targets)
