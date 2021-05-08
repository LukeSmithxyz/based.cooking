#!/usr/bin/make -f

BLOG := $(MAKE) -f $(lastword $(MAKEFILE_LIST)) --no-print-directory
ifneq ($(filter-out help,$(MAKECMDGOALS)),)
include config
endif

# The following can be configured in config
BLOG_DATE_FORMAT_INDEX ?= %x
BLOG_DATE_FORMAT ?= %x %X
BLOG_TITLE ?= blog
BLOG_DESCRIPTION ?= blog
BLOG_URL_ROOT ?= http://localhost/blog
BLOG_FEED_MAX ?= 20
BLOG_FEEDS ?= rss atom
BLOG_SRC ?= articles


.PHONY: help init build deploy clean taglist

ARTICLES = $(shell git ls-tree HEAD --name-only -- $(BLOG_SRC)/*.md 2>/dev/null)
TAGFILES = $(patsubst $(BLOG_SRC)/%.md,tags/%,$(ARTICLES))

help:
	$(info make init|build|deploy|clean|taglist)

init:
	mkdir -p $(BLOG_SRC) data templates
	printf '<!DOCTYPE html><html><head><title>$$TITLE</title></head><body>' > templates/header.html
	printf '</body></html>' > templates/footer.html
	printf '' > templates/index_header.html
	printf '<p>Tags:' > templates/tag_list_header.html
	printf '<a href="$$URL">$$NAME</a>' > templates/tag_entry.html
	printf ', ' > templates/tag_separator.html
	printf '</p>' > templates/tag_list_footer.html
	printf '<h2>Articles</h2><ul id=artlist>' > templates/article_list_header.html
	printf '<li><a href="$$URL">$$DATE $$TITLE</a></li>' > templates/article_entry.html
	printf '' > templates/article_separator.html
	printf '</ul>' > templates/article_list_footer.html
	printf '' > templates/index_footer.html
	printf '' > templates/tag_index_header.html
	printf '' > templates/tag_index_footer.html
	printf '' > templates/article_header.html
	printf '' > templates/article_footer.html
	printf 'blog\n' > .git/info/exclude

build: blog/index.html tagpages $(patsubst $(BLOG_SRC)/%.md,blog/%.html,$(ARTICLES)) $(patsubst %,blog/%.xml,$(BLOG_FEEDS))

deploy: build
	rsync -rLtvz $(BLOG_RSYNC_OPTS) blog/ data/ $(BLOG_REMOTE)

clean:
	rm -rf blog tags

config:
	printf 'BLOG_REMOTE:=%s\n' \
		'$(shell printf "Blog remote (eg: host:/var/www/html): ">/dev/tty; head -n1)' \
		> $@

tags/%: $(BLOG_SRC)/%.md
	mkdir -p tags
	grep -ih '^; *tags:' "$<" | cut -d: -f2- | tr -c '[^a-z\-]' ' ' | sed 's/  */\n/g' | sed '/^$$/d' | sort -u > $@

blog/index.html: index.md $(ARTICLES) $(TAGFILES) $(addprefix templates/,$(addsuffix .html,header index_header tag_list_header tag_entry tag_separator tag_list_footer article_list_header article_entry article_separator article_list_footer index_footer footer))
	mkdir -p blog
	TITLE="$(BLOG_TITLE)"; \
	PAGE_TITLE="$(BLOG_TITLE)"; \
	export TITLE; \
	export PAGE_TITLE; \
	envsubst < templates/header.html > $@; \
	envsubst < templates/index_header.html >> $@; \
	envsubst < templates/tag_list_header.html >> $@; \
	first=true; \
	for t in $(shell cat $(TAGFILES) | sort -u); do \
		"$$first" || envsubst < templates/tag_separator.html; \
		NAME="$$t" \
		URL="@$$t.html" \
		envsubst < templates/tag_entry.html; \
		first=false; \
	done >> $@; \
	envsubst < templates/tag_list_footer.html >> $@; \
	envsubst < templates/article_list_header.html >> $@; \
	first=true; \
	echo $(ARTICLES); \
	for f in $(ARTICLES); do \
		printf '%s ' "$$f"; \
		git log -n 1 --diff-filter=A --date="format:%s $(BLOG_DATE_FORMAT_INDEX)" --pretty=format:'%ad%n' -- "$$f"; \
	done | sort | cut -d" " -f1,3- | while IFS=" " read -r FILE DATE; do \
		"$$first" || envsubst < templates/article_separator.html; \
		URL="`printf '%s' "\$$FILE" | sed 's,^$(BLOG_SRC)/\(.*\).md,\1,'`.html" \
		DATE="$$DATE" \
		TITLE="`head -n1 "\$$FILE" | sed -e 's/^# //g'`" \
		envsubst < templates/article_entry.html; \
		first=false; \
	done >> $@; \
	envsubst < templates/article_list_footer.html >> $@; \
	markdown < index.md >> $@; \
	envsubst < templates/index_footer.html >> $@; \
	envsubst < templates/footer.html >> $@; \


blog/tag/%.html: $(ARTICLES) $(addprefix templates/,$(addsuffix .html,header tag_header index_entry tag_footer footer))

.PHONY: tagpages
tagpages: $(TAGFILES)
	+$(BLOG) $(patsubst %,blog/@%.html,$(shell cat $(TAGFILES) | sort -u))

blog/@%.html: $(TAGFILES) $(addprefix templates/,$(addsuffix .html,header tag_index_header tag_list_header tag_entry tag_separator tag_list_footer article_list_header article_entry article_separator article_list_footer tag_index_footer footer))
	mkdir -p blog
	PAGE_TITLE="Articles tagged $* -- $(BLOG_TITLE)"; \
	TAGS="$*"; \
	TITLE="$(BLOG_TITLE)"; \
	export PAGE_TITLE; \
	export TAGS; \
	export TITLE; \
	envsubst < templates/header.html > $@; \
	envsubst < templates/tag_index_header.html >> $@; \
	envsubst < templates/article_list_header.html >> $@; \
	first=true; \
	for f in $(shell awk '$$0 == "$*" { gsub("tags", "$(BLOG_SRC)", FILENAME); print FILENAME  ".md"; nextfile; }' $(TAGFILES)); do \
		printf '%s ' "$$f"; \
		git log -n 1 --diff-filter=A --date="format:%s $(BLOG_DATE_FORMAT_INDEX)" --pretty=format:'%ad%n' -- "$$f"; \
	done | sort | cut -d" " -f1,3- | while IFS=" " read -r FILE DATE; do \
		"$$first" || envsubst < templates/article_separator.html; \
		URL="`printf '%s' "\$$FILE" | sed 's,^$(BLOG_SRC)/\(.*\).md,\1,'`.html" \
		DATE="$$DATE" \
		TITLE="`head -n1 "\$$FILE" | sed -e 's/^# //g'`" \
		envsubst < templates/article_entry.html; \
		first=false; \
	done >> $@; \
	envsubst < templates/article_list_footer.html >> $@; \
	envsubst < templates/tag_index_footer.html >> $@; \
	envsubst < templates/footer.html >> $@; \


blog/%.html: $(BLOG_SRC)/%.md $(addprefix templates/,$(addsuffix .html,header article_header tag_link_header tag_link tag_link_footer article_footer footer))
	mkdir -p blog
	TITLE="$(shell head -n1 $< | sed 's/^# \+//')"; \
	export TITLE; \
	PAGE_TITLE="$${TITLE} Recipe -- $(BLOG_TITLE)"; \
	export PAGE_TITLE; \
	AUTHOR="$(shell git log --format="%an" -- "$<" | tail -n 1)"; \
	export AUTHOR; \
	DATE_POSTED="$(shell git log -n 1 --diff-filter=A --date="format:$(BLOG_DATE_FORMAT)" --pretty=format:'%ad' -- "$<")"; \
	export DATE_POSTED; \
	DATE_EDITED="$(shell git log -n 1 --date="format:$(BLOG_DATE_FORMAT)" --pretty=format:'%ad' -- "$<")"; \
	export DATE_EDITED; \
	TAGS="$(shell grep -i '^; *tags:' "$<" | cut -d: -f2- | paste -sd ',')"; \
	export TAGS; \
	envsubst < templates/header.html > $@; \
	envsubst < templates/article_header.html >> $@; \
	sed -e '/^;/d' < $< | markdown -f fencedcode >> $@; \
	envsubst < templates/tag_link_header.html >> $@; \
	for i in $${TAGS} ; do \
		TAG_NAME="$$i" \
		TAG_LINK="./@$$i.html" \
		envsubst < templates/tag_link.html >> $@; \
	done; \
	envsubst < templates/tag_link_footer.html >> $@; \
	envsubst < templates/article_footer.html >> $@; \
	envsubst < templates/footer.html >> $@; \

blog/rss.xml: $(ARTICLES)
	printf '<?xml version="1.0" encoding="UTF-8"?>\n<rss version="2.0">\n<channel>\n<title>%s</title>\n<link>%s</link>\n<description>%s</description>\n' \
		"$(BLOG_TITLE)" "$(BLOG_URL_ROOT)" "$(BLOG_DESCRIPTION)" > $@
	for f in $(ARTICLES); do \
		printf '%s ' "$$f"; \
		git log -n 1 --diff-filter=A --date="format:%s %a, %d %b %Y %H:%M:%S %z" --pretty=format:'%ad%n' -- "$$f"; \
	done | sort -k2nr | head -n $(BLOG_FEED_MAX) | cut -d" " -f1,3- | while IFS=" " read -r FILE DATE; do \
		printf '<item>\n<title>%s</title>\n<link>%s</link>\n<guid>%s</guid>\n<pubDate>%s</pubDate>\n<description><![CDATA[%s]]></description>\n</item>\n' \
			"`head -n 1 $$FILE | sed 's/^# //'`" \
			"$(BLOG_URL_ROOT)`basename $$FILE | sed 's/\.md/\.html/'`" \
			"$(BLOG_URL_ROOT)`basename $$FILE | sed 's/\.md/\.html/'`" \
			"$$DATE" \
			"`markdown < $$FILE`"; \
	done >> $@
	printf '</channel>\n</rss>\n' >> $@

blog/atom.xml: $(ARTICLES)
	printf '<?xml version="1.0" encoding="UTF-8"?>\n<feed xmlns="http://www.w3.org/2005/Atom" xml:lang="en">\n<title type="text">%s</title>\n<subtitle type="text">%s</subtitle>\n<updated>%s</updated>\n<link rel="alternate" type="text/html" href="%s"/>\n<id>%s</id>\n<link rel="self" type="application/atom+xml" href="%s"/>\n' \
		"$(BLOG_TITLE)" "$(BLOG_DESCRIPTION)" "$(shell date +%Y-%m-%dT%H:%M:%SZ)" "$(BLOG_URL_ROOT)" "$(BLOG_URL_ROOT)atom.xml" "$(BLOG_URL_ROOT)/atom.xml" > $@
	for f in $(ARTICLES); do \
		printf '%s ' "$$f"; \
		git log -n 1 --diff-filter=A --date="format:%s %Y-%m-%dT%H:%M:%SZ" --pretty=format:'%ad %aN%n' -- "$$f"; \
	done | sort -k2nr | head -n $(BLOG_FEED_MAX) | cut -d" " -f1,3- | while IFS=" " read -r FILE DATE AUTHOR; do \
		printf '<entry>\n<title type="text">%s</title>\n<link rel="alternate" type="text/html" href="%s"/>\n<id>%s</id>\n<published>%s</published>\n<updated>%s</updated>\n<author><name>%s</name></author>\n<summary type="html"><![CDATA[%s]]></summary>\n</entry>\n' \
			"`head -n 1 $$FILE | sed 's/^# //'`" \
			"$(BLOG_URL_ROOT)`basename $$FILE | sed 's/\.md/\.html/'`" \
			"$(BLOG_URL_ROOT)`basename $$FILE | sed 's/\.md/\.html/'`" \
			"$$DATE" \
			"`git log -n 1 --date="format:%Y-%m-%dT%H:%M:%SZ" --pretty=format:'%ad' -- "$$FILE"`" \
			"$$AUTHOR" \
			"`markdown < $$FILE`"; \
	done >> $@
	printf '</feed>\n' >> $@

taglist:
	grep -RIh '^;tags:' src | cut -d' ' -f2- | tr ' ' '\n' | sort | uniq
