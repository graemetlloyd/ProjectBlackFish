# SCRIPT TO BUILD METATREE FILES

# Load metatree library:
library(Claddis)
library(metatree)

# Reformat exclude TNT STR Output as proper Newick trees and save:
ExcludeSTRMPTs <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/ExcludeSTRMPTs.nex", warn = FALSE)
ExcludeSTRMPTs <- ExcludeSTRMPTs[grep("\\(allzero", ExcludeSTRMPTs)]
write(gsub(" ", "", ExcludeSTRMPTs), "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/ExcludeSTRMPTs.tre")

# Reformat genus TNT STR Output as proper Newick trees and save:
GenusSTRMPTs <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/GenusSTRMPTs.nex", warn = FALSE)
GenusSTRMPTs <- GenusSTRMPTs[grep("\\(allzero", GenusSTRMPTs)]
write(gsub(" ", "", GenusSTRMPTs), "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/GenusSTRMPTs.tre")

# Reformat all TNT STR Output as proper Newick trees and save:
AllSTRMPTs <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/AllSTRMPTs.nex", warn = FALSE)
AllSTRMPTs <- AllSTRMPTs[grep("\\(allzero", AllSTRMPTs)]
write(gsub(" ", "", AllSTRMPTs), "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/AllSTRMPTs.tre")

# Safely reinsert exclude taxa and write out to file:
Claddis::SafeTaxonomicReinsertion(treefile.in = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/ExcludeSTRMPTs.tre", treefile.out = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/ExcludeMPTs.tre", str.list = read.table("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Exclude/STR.txt", header = TRUE, stringsAsFactors = FALSE), multi.placements = "random")

# Safely reinsert genus taxa and write out to file:
Claddis::SafeTaxonomicReinsertion(treefile.in = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/GenusSTRMPTs.tre", treefile.out = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/GenusMPTs.tre", str.list = read.table("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Genus/STR.txt", header = TRUE, stringsAsFactors = FALSE), multi.placements = "random")

# Safely reinsert all taxa and write out to file:
Claddis::SafeTaxonomicReinsertion(treefile.in = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/AllSTRMPTs.tre", treefile.out = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/AllMPTs.tre", str.list = read.table("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/All/STR.txt", header = TRUE, stringsAsFactors = FALSE), multi.placements = "random")

# Get exclude strict consensuss and write to file:
ExcludeMPTs <- ape::read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/ExcludeMPTs.tre")
ExcludeSCC <- ape::consensus(ExcludeMPTs)
ape::write.tree(ExcludeSCC, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/StrictConsensusTrees/Exclude.tre")

# Get genus strict consensuss and write to file:
GenusMPTs <- ape::read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/GenusMPTs.tre")
GenusSCC <- ape::consensus(GenusMPTs)
ape::write.tree(GenusSCC, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/StrictConsensusTrees/Genus.tre")

# Get all strict consensuss and write to file:
AllMPTs <- ape::read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/AllMPTs.tre")
AllSCC <- ape::consensus(AllMPTs)
ape::write.tree(AllSCC, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/StrictConsensusTrees/All.tre")
