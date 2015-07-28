## Planteome root importer

This repository contains the necessary components to construct the
complete linked set of ontologies used by Planteome. This can be used
in a variety of contexts:

 * Single point of configuration for loading the planteome AmiGO instance
 * An entry point for OWL tooling that validates all planteome ontologies
 * A means to bundle a single artefact for downstream analysis

The central component is the *importer ontology*
[planteome.owl](planteome.owl), which is a collection of owl:imports
statements that list all ontologies to be imported. imports may be
recursive. Each ontology is named by the URL from which it is
available.

## Usage

The basic way to use this is to point any OWL compliant tool at:

 * [planteome.owl](planteome.owl)

TODO: register this as a PURL

Whether the OWL tool is Protege or something built on the OWLAPI stack
(e.g. AmiGO loader) it will know how to pull in all the various
imported ontologies.

## Mirroring

To avoid pulling all imported ontologies over the web, you can do this:

    make local-mirror

This requires owltools on the command line. It will place a copy of
each imported ontologies in the `mirror/` directory. Additionally, it
will create a file `mirror/catalog-v001.xml`, which is a mapping
between ontology IRIs (names) and their local filename.

Most OWL tooling understands the catalog file. Protege should use it
automatically. Anything owltools related can read it using the
`--catalog-xml` argument.

For more, see the [owltools import chain mirroring docs](https://github.com/owlcollab/owltools/wiki/Import-Chain-Mirroring)

## Validation

The [Makefile](makefile) here contains targets for doing automated
validation using OWLTools. It is intended to be used in a continuous
integration (CI) environment.

For more on CI, see [this post](https://douroucouli.wordpress.com/2012/02/16/ontologies-and-continuous-integration/)




