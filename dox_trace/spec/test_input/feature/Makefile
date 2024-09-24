
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = build
CONFIGDIR     = .

.PHONY: Makefile

%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" -c "$(CONFIGDIR)" -W $(SPHINXOPTS) $(O)
