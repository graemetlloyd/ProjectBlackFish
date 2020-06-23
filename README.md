# ProjectBlackFish

This is the GitHub repository for the cetacean metatree project (authors [Graeme Lloyd](https://github.com/graemetlloyd) and [Graham Slater](https://github.com/grahamjslater)), code-named Project Blackfish.

## What is here

The below explains the file structure of the repository.

### Excluded data

(Hidden) Folder of PDFs of papers that could not be included in the metatree as they lack accessible character-taxon matrices.

### fossilBAMM

Folder containing the R scripts for the fossilBAMM diversification analyses and the following subfolders:

#### ALL

Subfolder containing the results for the ALL fossilBAMM analyses.

#### EXCLUDE

Subfolder containing the results for the EXCLUDE fossilBAMM analyses.

#### GENUS

Subfolder containing the results for the GENUS fossilBAMM analyses.

### Input data

Folder containing the following subfolders:

#### MRP

Matrix Representations with Parsimony (MRPs) obtained by re-analysing each input data set under parsimony and retaining only unique biparitions until all such biparitions have been sampled.

#### NEXUS

The original character-taxon matrices for each input data set.

#### PDF

(Hidden) PDFs of the published articles for each input data set.

#### WaitingRoom

A series of the same folders as Input data containing input data sets formatted ready for use, but only recently discoevered so not included in the current metatree iteration. Typically these will correspond to very recent publications.

#### XML

XML files that record important metadata about each input data set, particularly data set dependence and taxonomic reconciliation.

### LICENSE

The license under which this repository exists.

### Metatree data

Folder containing the metatree data organised in the following subfolders:

### McGowan_molecular_analysis

Folder containing the molecular analysis used as constraint topologies for the extant taxa.

### Metatree data

Folder containing the metatree data organised in the following subfolders:

#### All

The metatree files for the "all" (full taxonomic coverage) metatree.

### FullTrees

The full metatree MPT samples (post safe taxonomic reinsertion).

#### Exclude

The metatree files for the "exclude" (lowest taxonomic coverage) metatree.

#### Genus

The metatree files for the "genus" (middle taxonomic coverage) metatree.

#### StrictConsensusTrees

The strict consensus trees used as inputs for the timetree analyses.

#### STRTrees

The safe taxonmic reduction trees returned from TNT analysis of the exclude, genus and all metatree matrices.

### README

This file.

### RScripts

The set of R scripts used to: 1. populate the repository, 2. generate the metatree files, and 3. process the metree output.

### Timetree data

The timetrees (empty).

### TimeTreeInference

Folder containing the R scripts and temporal data used to build the timetrees as well as the following subfolders:

#### ALL

Subfolder containing the results for the ALL timetree analyses.

#### EXCLUDE

Subfolder containing the results for the EXCLUDE timetree analyses.

#### GENUS

Subfolder containing the results for the GENUS timetree analyses.
