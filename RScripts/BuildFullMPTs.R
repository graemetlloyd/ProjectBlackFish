# SCRIPT TO BUILD METATREE FILES

# Load metatree library:
library(Claddis)
library(metatree)

# Reformat safe TNT STR Output as proper Newick trees and save:
SafeSTRMPTs <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/SafeSTRMPTs.nex", warn = FALSE)
SafeSTRMPTs <- SafeSTRMPTs[grep("\\(allzero", SafeSTRMPTs)]
write(gsub(" ", "", SafeSTRMPTs), "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/SafeSTRMPTs.tre")

# Reformat risky TNT STR Output as proper Newick trees and save:
RiskySTRMPTs <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/RiskySTRMPTs.nex", warn = FALSE)
RiskySTRMPTs <- RiskySTRMPTs[grep("\\(allzero", RiskySTRMPTs)]
write(gsub(" ", "", RiskySTRMPTs), "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/RiskySTRMPTs.tre")

# Reformat dangerous TNT STR Output as proper Newick trees and save:
DangerousSTRMPTs <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/DangerousSTRMPTs.nex", warn = FALSE)
DangerousSTRMPTs <- DangerousSTRMPTs[grep("\\(allzero", DangerousSTRMPTs)]
write(gsub(" ", "", DangerousSTRMPTs), "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/DangerousSTRMPTs.tre")

# Reformat NoWeighting TNT STR Output as proper Newick trees and save:
NoWeightingSTRMPTs <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/NoWeightingSTRMPTs.nex", warn = FALSE)
NoWeightingSTRMPTs <- NoWeightingSTRMPTs[grep("\\(allzero", NoWeightingSTRMPTs)]
write(gsub(" ", "", NoWeightingSTRMPTs), "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/NoWeightingSTRMPTs.tre")

# Reformat NoTaxonTreeVersion TNT STR Output as proper Newick trees and save:
NoTaxonTreeVersionSTRMPTs <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/NoTaxonTreeVersionSTRMPTs.nex", warn = FALSE)
NoTaxonTreeVersionSTRMPTs <- NoTaxonTreeVersionSTRMPTs[grep("\\(allzero", NoTaxonTreeVersionSTRMPTs)]
write(gsub(" ", "", NoTaxonTreeVersionSTRMPTs), "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/NoTaxonTreeVersionSTRMPTs.tre")

# Reformat RandomWeighting TNT STR Output as proper Newick trees and save:
z <- lapply(as.list(list.files("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees", full.names = TRUE)[grep("RandomWeighting", list.files("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees"))]), function(x) {y <- readLines(x); y <- y[grep("\\(allzero", y)]; write(gsub(" ", "", y), gsub(".nex", ".tre", x))})

# Safely reinsert safe taxa and write out to file:
Claddis::safe_taxonomic_reinsertion(input_filename = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/SafeSTRMPTs.tre", output_filename = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/SafeMPTs.tre", str_taxa = read.table("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Safe/STR.txt", header = TRUE, stringsAsFactors = FALSE), multiple_placement_option = "random")

# Safely reinsert risky taxa and write out to file:
Claddis::safe_taxonomic_reinsertion(input_filename = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/RiskySTRMPTs.tre", output_filename = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/RiskyMPTs.tre", str_taxa = read.table("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Risky/STR.txt", header = TRUE, stringsAsFactors = FALSE), multiple_placement_option = "random")

# Safely reinsert dangerous taxa and write out to file:
Claddis::safe_taxonomic_reinsertion(input_filename = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/DangerousSTRMPTs.tre", output_filename = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/DangerousMPTs.tre", str_taxa = read.table("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Dangerous/STR.txt", header = TRUE, stringsAsFactors = FALSE), multiple_placement_option = "random")

# Safely reinsert NoWeighting taxa and write out to file:
Claddis::safe_taxonomic_reinsertion(input_filename = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/NoWeightingSTRMPTs.tre", output_filename = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/NoWeightingMPTs.tre", str_taxa = read.table("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/NoWeighting/STR.txt", header = TRUE, stringsAsFactors = FALSE), multiple_placement_option = "random")

# Safely reinsert NoTaxonTreeVersion taxa and write out to file:
Claddis::safe_taxonomic_reinsertion(input_filename = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees/NoTaxonTreeVersionSTRMPTs.tre", output_filename = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/NoTaxonTreeVersionMPTs.tre", str_taxa = read.table("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/NoTaxonTreeVersion/STR.txt", header = TRUE, stringsAsFactors = FALSE), multiple_placement_option = "random")

# Safely reinsert RandomWeighting taxa and write out to file:
z <- lapply(as.list(list.files("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees", full.names = TRUE)[intersect(grep("RandomWeighting", list.files("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees")), grep(".tre", list.files("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/STRTrees")))]), function(x) Claddis::safe_taxonomic_reinsertion(input_filename = x, output_filename = paste0("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/", gsub("STR", "", rev(strsplit(x, "/")[[1]])[1])), str_taxa = read.table("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Safe/STR.txt", header = TRUE, stringsAsFactors = FALSE), multiple_placement_option = "random"))

# Get safe strict consensus and write to file:
SafeMPTs <- ape::read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/SafeMPTs.tre")
SafeSCC <- ape::consensus(SafeMPTs)
ape::write.tree(SafeSCC, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/StrictConsensusTrees/Safe.tre")

# Get risky strict consensus and write to file:
RiskyMPTs <- ape::read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/RiskyMPTs.tre")
RiskySCC <- ape::consensus(RiskyMPTs)
ape::write.tree(RiskySCC, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/StrictConsensusTrees/Risky.tre")

# Get dangerous strict consensus and write to file:
DangerousMPTs <- ape::read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/DangerousMPTs.tre")
DangerousSCC <- ape::consensus(DangerousMPTs)
ape::write.tree(DangerousSCC, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/StrictConsensusTrees/Dangerous.tre")

# Get NoWeighting strict consensus and write to file:
NoWeightingMPTs <- ape::read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/NoWeightingMPTs.tre")
NoWeightingSCC <- ape::consensus(NoWeightingMPTs)
ape::write.tree(NoWeightingSCC, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/StrictConsensusTrees/NoWeighting.tre")

# Get NoTaxonTreeVersion strict consensus and write to file:
NoTaxonTreeVersionMPTs <- ape::read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees/NoTaxonTreeVersionMPTs.tre")
NoTaxonTreeVersionSCC <- ape::consensus(NoTaxonTreeVersionMPTs)
ape::write.tree(NoTaxonTreeVersionSCC, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/StrictConsensusTrees/NoTaxonTreeVersion.tre")

# Get RandomWeighting strict consensuses and write to file:
z <- lapply(as.list(list.files("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees", full.names = TRUE)[grep("RandomWeighting", list.files("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/FullTrees"))]), function(x) {y <- ape::read.tree(x); y <- ape::consensus(y); ape::write.tree(y, gsub("MPTs", "", gsub("FullTrees", "StrictConsensusTrees", x)))})
