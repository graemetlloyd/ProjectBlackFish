rm(list=ls())
library(ape);
library(geiger)
library(paleotree)
source("~/Dropbox/ProjectBlackFish/TimeTreeInference/BuildBeastXML.R")

setwd("~/Dropbox/ProjectBlackFish/")

### read in constraint tree (MRP consensus, MRL tree etc )
### then read in stratigraphic data in csv format
### strat data should be csv file with name, fad, lad
### finally, read in molecular alignment for extant taxa

constraintTree <- read.tree("")
StratRanges <- read.csv("", row.names = 1, stringsAsFactors = F)
alignment <- read.nexus.data("")


# if taxon names in strat range contain spaces, uncomment and run line below
rownames(StratRanges)<-gsub(" ", "_", rownames(StratRanges))

#if age ranges larger than some amount are not desirable run two lines below
# max.age.range <- 11
#StratRanges<-StratRanges[-which(StratRanges$range>max.age.range),] ## remove taxa with large strat ranges

## remove NAs (= missing dates) ##
## make a file naming dropped taxa
write.table(t(names(which(is.na(apply(StratRanges,1, mean))))), file="missing.txt", quote=F, sep="\t") 
StratRanges <- StratRanges[-which(is.na(apply(StratRanges,1, mean))), ]


name.check(constraintTree, StratRanges)
td <- treedata(constraintTree, StratRanges)



phy <- td$phy
StratRanges <- td$data

fileStem = "myfileName"
PrepareBeastMetatree(constraintTree = constraintTree, 
                     StratRanges = StratRanges, 
                     alignment = alignment, 
                     myfileName = myfileName,
                     makeStartTree = TRUE, 
                     start.tree.method="mbl", 
                     vartime=0.5)

## output will be a series of files that can be used to create a BEAST xml through beauti
## i.e. nexus file and mean taxon ages
## as well as files that can be pasted into the xml (monophyly constraints, starting tree, age ranges).
