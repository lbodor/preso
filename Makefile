html:
	./generate-html.sh

once:
	./generate-html.sh once

run: once
	find . -name "*.html" -and -not -name "header.html" | sort | xargs firefox &
	$(MAKE) html

clean:
	rm -rf *.md
	find . -name "*.html" -and -not -name "header.html" | xargs rm -f
