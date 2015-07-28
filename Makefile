OBO=http://purl.obolibrary.org/obo
CATALOG = mirror/catalog-v001.xml
USECAT= --catalog-xml $(CATALOG)
MIRROR= mirror
ONTROOT= planteome
ROOT= $(ONTROOT).owl

all: $(CATALOG) planteome-validate.txt planteome-merged.obo 

local-mirror: $(CATALOG)

# See: https://github.com/owlcollab/owltools/wiki/Import-Chain-Mirroring
$(CATALOG): $(ROOT)
	owltools $< --slurp-import-closure -d $(MIRROR) -c $@ --merge-imports-closure -o $(MIRROR)/merged.owl

# use this to repair individual items in the cache
$(MIRROR)/%.owl:
	wget --no-check-certificate http://$*.owl -O $@


# bundled
%-merged.owl: %.owl $(CATALOG)
	owltools $(USECAT) $< --merge-imports-closure -o $@

%-validate.txt: %.owl
	owltools $(USECAT) $< --run-reasoner -r elk -u > $@

%-reasoned.owl: %.owl
	owltools $(USECAT) $< --run-reasoner -r elk --assert-implied --remove-redundant-inferred-super-classes -o $@

%.obo: %.owl
	owltools $< --extract-mingraph --remove-axiom-annotations -o -f obo --no-check $@.tmp && grep -v ^owl-axiom $@.tmp > $@
