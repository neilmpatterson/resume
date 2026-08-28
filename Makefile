NAME := Neil-Patterson
YEAR := $(shell date +%y)
MONTH := $(shell date +%m | sed 's/^0//')
REVISION := $(shell max=0; for file in versions/neil_patterson_v$(YEAR).$(MONTH).*\.pdf; do [ -e "$$file" ] || continue; revision=$$(printf '%s\n' "$$file" | sed -E 's/.*v[0-9]+\.[0-9]+\.([0-9]+)\.pdf/\1/'); [ "$$revision" -gt "$$max" ] 2>/dev/null && max=$$revision; done; echo $$((max + 1)))
VERSION := $(YEAR).$(MONTH).$(REVISION)
OUTPUT := versions/neil_patterson_v$(VERSION).pdf
LATEST := resume.pdf

.PHONY: all clean

all: $(OUTPUT)

$(OUTPUT): resume.tex awesome-cv.cls $(wildcard fonts/*)
	mkdir -p build versions
	xelatex -interaction=nonstopmode -halt-on-error -output-directory=build resume.tex
	xelatex -interaction=nonstopmode -halt-on-error -output-directory=build resume.tex
	cp build/resume.pdf $(OUTPUT)
	cp build/resume.pdf $(LATEST)

clean:
	rm -rf build
