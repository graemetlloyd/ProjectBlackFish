rm(list=ls())
library(ape);
library(geiger)
library(paleotree)
#<<<<<<< HEAD
source("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/BuildBeastXML.R")

setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish")

### read in constraint tree (MRP consensus, MRL tree etc )
### then read in stratigraphic data in csv format
### strat data should be csv file with name, fad, lad
### finally, read in molecular alignment for extant taxa


constraintTree <- read.tree("MRL/Dangerous_MRL_reinsert.tre")
StratRanges <- read.csv("cetacean_ages_update.csv", row.names = 1, stringsAsFactors = FALSE)
StratRanges<-StratRanges[-which(is.na(StratRanges[,1])),]
# if taxon names in strat range contain spaces, uncomment and run line below
rownames(StratRanges)<-gsub(" ", "_", rownames(StratRanges))
alignment <- read.nexus.data("TimeTreeInference/pruned_cytb_alignment.nex")


setdiff(rownames(StratRanges)[which(StratRanges[,2]==0)], names(alignment))


#if age ranges larger than some amount are not desirable run two lines below
max.age.range <- 15
StratRanges <- StratRanges[-which(StratRanges[,1]-StratRanges[,2]>max.age.range),] ## remove taxa with large strat ranges


td<-treedata(constraintTree, StratRanges)

constraintTree <- td$phy
StratRanges <- td$data

fileStem = "TimeTreeInference/Risky/Cetacea_Dangerous"

PrepareBeastMetatree(constraintTree = constraintTree, 
                     StratRanges = StratRanges, 
                     alignment = alignment, 
                     myfileName = fileStem,
                     makeStartTree = TRUE, 
                     start.tree.method = "mbl",
                     vartime = 0.5)

## output will be a series of files that can be used to create a BEAST xml through beauti
## i.e. nexus file and mean taxon ages
## as well as files that can be pasted into the xml (monophyly constraints, starting tree, age ranges).
