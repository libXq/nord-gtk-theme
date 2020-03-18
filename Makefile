SASS=sassc
SASSFLAGS= -I
GLIB_COMPILE_RESOURCES=glib-compile-resources

RES_DIR320=gtk-3.20
SCSS_DIR320=$(RES_DIR320)/scss
DIST_DIR320=$(RES_DIR320)/dist

$(DIST_DIR320):
	mkdir -p "$@"

$(DIST_DIR320)/gtk.css: $(DIST_DIR320)
	$(SASS) $(SASSFLAGS) "$(SCSS_DIR320)" "$(SCSS_DIR320)/gtk.scss" "$@"

$(DIST_DIR320)/gtk-dark.css: $(DIST_DIR320)/gtk.css
ifneq ("$(wildcard $(SCSS_DIR320)/gtk-dark.scss)","")
	$(SASS) $(SASSFLAGS) "$(SCSS_DIR320)" "$(SCSS_DIR320)/gtk-dark.scss" "$@"
else
	cp "$(DIST_DIR320)/gtk.css" "$@"
endif

css_gtk320: $(DIST_DIR320)/gtk-dark.css $(DIST_DIR320)/gtk.css
.PHONY: css_gtk320

$(RES_DIR320)/gtk.gresource: css_gtk320
	$(GLIB_COMPILE_RESOURCES) --sourcedir="$(RES_DIR320)" "$@.xml"

gresource_gtk320: $(RES_DIR320)/gtk.gresource
.PHONY: gresource_gtk320

clean_gtk320:
	rm -rf "$(DIST_DIR320)"
	rm -f "$(RES_DIR320)/gtk.gresource"
.PHONY: clean_gtk320

gtk320:
	$(MAKE) clean_gtk320
	$(MAKE) gresource_gtk320
.PHONY: gtk320

clean: clean_gtk320
.PHONY: clean

all: gtk320
.PHONY: all

.DEFAULT_GOAL := all