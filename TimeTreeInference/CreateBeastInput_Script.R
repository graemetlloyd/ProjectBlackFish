rm(list=ls())
library(ape);
library(geiger)
library(paleotree)
<<<<<<< HEAD
source("~/Dropbox/ProjectBlackFish/TimeTreeInference/BuildBeastXML.R")

setwd("~/Dropbox/ProjectBlackFish/")
=======
source("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/BuildBeastXML.R")

setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/")
>>>>>>> 17237b707d994fe504b5385dfbce37f08953b3cd

### read in constraint tree (MRP consensus, MRL tree etc )
### then read in stratigraphic data in csv format
### strat data should be csv file with name, fad, lad
### finally, read in molecular alignment for extant taxa

<<<<<<< HEAD
constraintTree <- read.tree("")
StratRanges <- read.csv("", row.names = 1, stringsAsFactors = F)
alignment <- read.nexus.data("")
=======
## choose appropriate tree here: 
#constraintTree <- read.tree("Metatree data/StrictConsensusTrees/Exclude.tre")
#constraintTree <- read.tree("Metatree data/StrictConsensusTrees/Genus.tre")
constraintTree <- read.tree("TimeTreeInference/ALL/MRL/ALL_MRL.tre")

StratRanges <- read.csv("TimeTreeInference/whale_ages.csv",  stringsAsFactors = F, row.names = 1)

alignment <- read.nexus.data("TimeTreeInference/pruned_cytb_alignment.nex")
>>>>>>> 17237b707d994fe504b5385dfbce37f08953b3cd


# if taxon names in strat range contain spaces, uncomment and run line below
rownames(StratRanges)<-gsub(" ", "_", rownames(StratRanges))

#if age ranges larger than some amount are not desirable run two lines below
<<<<<<< HEAD
# max.age.range <- 11
#StratRanges<-StratRanges[-which(StratRanges$range>max.age.range),] ## remove taxa with large strat ranges

## remove NAs (= missing dates) ##
## make a file naming dropped taxa
write.table(t(names(which(is.na(apply(StratRanges,1, mean))))), file="missing.txt", quote=F, sep="\t") 
=======
max.age.range <- 11
StratRanges<-StratRanges[-which(StratRanges$range>max.age.range),] ## remove taxa with large strat ranges
## remove NAs (= missing dates) ##
>>>>>>> 17237b707d994fe504b5385dfbce37f08953b3cd
StratRanges <- StratRanges[-which(is.na(apply(StratRanges,1, mean))), ]


name.check(constraintTree, StratRanges)
td <- treedata(constraintTree, StratRanges)



<<<<<<< HEAD
phy <- td$phy
StratRanges <- td$data

fileStem = "myfileName"
PrepareBeastMetatree(constraintTree = constraintTree, 
                     StratRanges = StratRanges, 
                     alignment = alignment, 
                     myfileName = myfileName,
=======
constraintTree <- td$phy
StratRanges <- td$data

fileStem = "ALL"
PrepareBeastMetatree(constraintTree = constraintTree, 
                     StratRanges = StratRanges, 
                     alignment = alignment, 
                     myfileName = fileStem,
>>>>>>> 17237b707d994fe504b5385dfbce37f08953b3cd
                     makeStartTree = TRUE, 
                     start.tree.method="mbl", 
                     vartime=0.5)

## output will be a series of files that can be used to create a BEAST xml through beauti
## i.e. nexus file and mean taxon ages
## as well as files that can be pasted into the xml (monophyly constraints, starting tree, age ranges).
