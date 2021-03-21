SEM=spring2021
CONTENT = ~/server/static/content/ec327_spring2021
SOURCES := ec327spr21_lab4_git.md
HTML = $(SOURCES:.md=.html)
PDF = $(SOURCES:.md=.pdf)
USER = jeffreycarruthers@curl.bu.edu

%.html: %.md
	pandoc -s --toc  --toc-depth=2 --css="https://curl.bu.edu:32721/static/style.css" --number-sections -o $@ $<

%.pdf: %.md
	pandoc  --toc --toc-depth=2 --number-sections -o $@ $<

all: $(HTML) $(PDF)


install:
	scp *.html *.pdf $(USER):$(CONTENT)

