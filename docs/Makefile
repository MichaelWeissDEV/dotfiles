# Minimal makefile for Sphinx documentation
SPHINXOPTS    ?= -W --keep-going
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build

.PHONY: help clean html dirhtml

help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

clean:
	rm -rf "$(BUILDDIR)"/*

html:
	@$(SPHINXBUILD) -b html "$(SOURCEDIR)" "$(BUILDDIR)/html" $(SPHINXOPTS) $(O)

dirhtml:
	@$(SPHINXBUILD) -b dirhtml "$(SOURCEDIR)" "$(BUILDDIR)/dirhtml" $(SPHINXOPTS) $(O)
