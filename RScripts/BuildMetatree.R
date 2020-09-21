# SCRIPT TO BUILD METATREE FILES

# Load metatree library:
library(metatree)

# Set directory paths (Spencer, you will want to edit these for your own local version):
MRPDirectory <- "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Input data/MRP"
XMLDirectory <- "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Input data/XML"
MetatreeDirectory <- ""

# Standard exclusive data list (supertrees and the like):
ExclusiveDataList <- c("Averianov_2016a", "Bravo_et_Gaete_2015a", "Brocklehurst_etal_2013a", "Brocklehurst_etal_2015aa", "Brocklehurst_etal_2015ab", "Brocklehurst_etal_2015ac", "Brocklehurst_etal_2015ad", "Brocklehurst_etal_2015ae", "Brocklehurst_etal_2015af", "Bronzati_etal_2012a", "Bronzati_etal_2015ab", "Brusatte_etal_2009ba", "Campbell_etal_2016ab", "Carr_et_Williamson_2004a", "Carr_etal_2017ab", "Frederickson_et_Tumarkin-Deratzian_2014aa", "Frederickson_et_Tumarkin-Deratzian_2014ab", "Frederickson_et_Tumarkin-Deratzian_2014ac", "Frederickson_et_Tumarkin-Deratzian_2014ad", "Garcia_etal_2006a", "Gatesy_etal_2004ab", "Grellet-Tinner_2006a", "Grellet-Tinner_et_Chiappe_2004a", "Grellet-Tinner_et_Makovicky_2006a", "Jin_etal_2010a", "Knoll_2008a", "Kurochkin_1996a", "Lopez-Martinez_et_Vicens_2012a", "Lu_etal_2014aa", "Norden_etal_2018a", "Pisani_etal_2002a", "Ruiz-Omenaca_etal_1997a", "Ruta_etal_2003ba", "Ruta_etal_2003bb", "Ruta_etal_2007a", "Schaeffer_etal_inpressa", "Selles_et_Galobart_2016a", "Sereno_1993a", "Sidor_2001a","Sidor_2003a", "Skutschas_etal_2019a", "Tanaka_etal_2011a", "Toljagic_et_Butler_2013a", "Tsuihiji_etal_2011aa", "Varricchio_et_Jackson_2004a", "Vila_etal_2017a", "Wilson_2005aa", "Wilson_2005ab", "Zelenitsky_et_Therrien_2008a")

# Build safe cetacean metatree:
CetaceaSafe <- metatree::Metatree(MRPDirectory = MRPDirectory, XMLDirectory = XMLDirectory, TargetClade = "Cetacea", InclusiveDataList = c(), ExclusiveDataList = ExclusiveDataList, MissingSpecies = "exclude", RelativeWeights = c(0, 1, 1, 1), WeightCombination = "product", ReportContradictionsToScreen = FALSE)

# Build risky cetacean metatree:
CetaceaRisky <- metatree::Metatree(MRPDirectory = MRPDirectory, XMLDirectory = XMLDirectory, TargetClade = "Cetacea", InclusiveDataList = c(), ExclusiveDataList = ExclusiveDataList, MissingSpecies = "genus", RelativeWeights = c(0, 1, 1, 1), WeightCombination = "product", ReportContradictionsToScreen = FALSE)

# Build dangerous cetacean metatree:
CetaceaDangeous <- metatree::Metatree(MRPDirectory = MRPDirectory, XMLDirectory = XMLDirectory, TargetClade = "Cetacea", InclusiveDataList = c(), ExclusiveDataList = ExclusiveDataList, MissingSpecies = "all", RelativeWeights = c(0, 1, 1, 1), WeightCombination = "product", ReportContradictionsToScreen = FALSE)

# Build McGowen only MRP:
McGowenSafe <- McGowenRisky <- McGowenDangerous <- metatree::Metatree(MRPDirectory = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Input data/McGowen_etal_2009a/MRP", XMLDirectory = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Input data/McGowen_etal_2009a/XML", TargetClade = "Cetacea", InclusiveDataList = c(), ExclusiveDataList = c(), MissingSpecies = "exclude", RelativeWeights = c(1, 0, 0, 0), WeightCombination = "product", ReportContradictionsToScreen = FALSE, ExcludeTaxonomyMRP = TRUE)

# Collapse McGowen matrices down to just taxa present in each of safe, risky and dangerous:
McGowenSafe$FullMRPMatrix$matrix_1$matrix <- McGowenSafe$FullMRPMatrix$matrix_1$matrix[intersect(rownames(McGowenSafe$FullMRPMatrix$matrix_1$matrix), rownames(CetaceaSafe$FullMRPMatrix$matrix_1$matrix)), ]
McGowenRisky$FullMRPMatrix$matrix_1$matrix <- McGowenRisky$FullMRPMatrix$matrix_1$matrix[intersect(rownames(McGowenRisky$FullMRPMatrix$matrix_1$matrix), rownames(CetaceaRisky$FullMRPMatrix$matrix_1$matrix)), ]
McGowenDangerous$FullMRPMatrix$matrix_1$matrix <- McGowenDangerous$FullMRPMatrix$matrix_1$matrix[intersect(rownames(McGowenDangerous$FullMRPMatrix$matrix_1$matrix), rownames(CetaceaDangerous$FullMRPMatrix$matrix_1$matrix)), ]

# Prune any now duplicated characters in McGowen data sets:
McGowenSafe$FullMRPMatrix <- metatree::PisaniMRPPrune(McGowenSafe$FullMRPMatrix)
McGowenRisky$FullMRPMatrix <- metatree::PisaniMRPPrune(McGowenRisky$FullMRPMatrix)
McGowenDangerous$FullMRPMatrix <- metatree::PisaniMRPPrune(McGowenDangerous$FullMRPMatrix)

# Place McGowen character weights on 999 to 1000 scale:
McGowenSafe$FullMRPMatrix$matrix_1$character_weights <- plotrix::rescale(McGowenSafe$FullMRPMatrix$matrix_1$character_weights, c(999, 1000))
McGowenRisky$FullMRPMatrix$matrix_1$character_weights <- plotrix::rescale(McGowenRisky$FullMRPMatrix$matrix_1$character_weights, c(999, 1000))
McGowenDangerous$FullMRPMatrix$matrix_1$character_weights <- plotrix::rescale(McGowenDangerous$FullMRPMatrix$matrix_1$character_weights, c(999, 1000))

# Add in taxa missing from McGowen as all NAs:
McGowenSafe$FullMRPMatrix$matrix_1$matrix <- rbind(McGowenSafe$FullMRPMatrix$matrix_1$matrix, matrix(rep(NA, (nrow(CetaceaSafe$FullMRPMatrix$matrix_1$matrix) - nrow(McGowenSafe$FullMRPMatrix$matrix_1$matrix)) * ncol(McGowenSafe$FullMRPMatrix$matrix_1$matrix)), nrow = nrow(CetaceaSafe$FullMRPMatrix$matrix_1$matrix) - nrow(McGowenSafe$FullMRPMatrix$matrix_1$matrix), dimnames = list(setdiff(rownames(CetaceaSafe$FullMRPMatrix$matrix_1$matrix), rownames(McGowenSafe$FullMRPMatrix$matrix_1$matrix)), c())))
McGowenRisky$FullMRPMatrix$matrix_1$matrix <- rbind(McGowenRisky$FullMRPMatrix$matrix_1$matrix, matrix(rep(NA, (nrow(CetaceaRisky$FullMRPMatrix$matrix_1$matrix) - nrow(McGowenRisky$FullMRPMatrix$matrix_1$matrix)) * ncol(McGowenRisky$FullMRPMatrix$matrix_1$matrix)), nrow = nrow(CetaceaRisky$FullMRPMatrix$matrix_1$matrix) - nrow(McGowenRisky$FullMRPMatrix$matrix_1$matrix), dimnames = list(setdiff(rownames(CetaceaRisky$FullMRPMatrix$matrix_1$matrix), rownames(McGowenRisky$FullMRPMatrix$matrix_1$matrix)), c())))
McGowenDangerous$FullMRPMatrix$matrix_1$matrix <- rbind(McGowenDangerous$FullMRPMatrix$matrix_1$matrix, matrix(rep(NA, (nrow(CetaceaDangerous$FullMRPMatrix$matrix_1$matrix) - nrow(McGowenDangerous$FullMRPMatrix$matrix_1$matrix)) * ncol(McGowenDangerous$FullMRPMatrix$matrix_1$matrix)), nrow = nrow(CetaceaDangerous$FullMRPMatrix$matrix_1$matrix) - nrow(McGowenDangerous$FullMRPMatrix$matrix_1$matrix), dimnames = list(setdiff(rownames(CetaceaDangerous$FullMRPMatrix$matrix_1$matrix), rownames(McGowenDangerous$FullMRPMatrix$matrix_1$matrix)), c())))

# Duplicate McGowen twenty times to upweight it:
McGowenSafe$FullMRPMatrix <- metatree::EmbiggenMatrix(McGowenSafe$FullMRPMatrix, 20)
McGowenRisky$FullMRPMatrix <- metatree::EmbiggenMatrix(McGowenRisky$FullMRPMatrix, 20)
McGowenDangerous$FullMRPMatrix <- metatree::EmbiggenMatrix(McGowenDangerous$FullMRPMatrix, 20)

# Combine McGowen and morphology MRPs:
CetaceaSafe$FullMRPMatrix$matrix_1$matrix <- cbind(CetaceaSafe$FullMRPMatrix$matrix_1$matrix, McGowenSafe$FullMRPMatrix$matrix_1$matrix[rownames(CetaceaSafe$FullMRPMatrix$matrix_1$matrix), ])
CetaceaSafe$FullMRPMatrix$matrix_1$ordering <- c(CetaceaSafe$FullMRPMatrix$matrix_1$ordering, McGowenSafe$FullMRPMatrix$matrix_1$ordering)
CetaceaSafe$FullMRPMatrix$matrix_1$character_weights <- c(CetaceaSafe$FullMRPMatrix$matrix_1$character_weights, McGowenSafe$FullMRPMatrix$matrix_1$character_weights)
CetaceaSafe$FullMRPMatrix$matrix_1$minimum_values <- c(CetaceaSafe$FullMRPMatrix$matrix_1$minimum_values, McGowenSafe$FullMRPMatrix$matrix_1$minimum_values)
CetaceaSafe$FullMRPMatrix$matrix_1$maximum_values <- c(CetaceaSafe$FullMRPMatrix$matrix_1$maximum_values, McGowenSafe$FullMRPMatrix$matrix_1$maximum_values)
CetaceaRisky$FullMRPMatrix$matrix_1$matrix <- cbind(CetaceaRisky$FullMRPMatrix$matrix_1$matrix, McGowenRisky$FullMRPMatrix$matrix_1$matrix[rownames(CetaceaRisky$FullMRPMatrix$matrix_1$matrix), ])
CetaceaRisky$FullMRPMatrix$matrix_1$ordering <- c(CetaceaRisky$FullMRPMatrix$matrix_1$ordering, McGowenRisky$FullMRPMatrix$matrix_1$ordering)
CetaceaRisky$FullMRPMatrix$matrix_1$character_weights <- c(CetaceaRisky$FullMRPMatrix$matrix_1$character_weights, McGowenRisky$FullMRPMatrix$matrix_1$character_weights)
CetaceaRisky$FullMRPMatrix$matrix_1$minimum_values <- c(CetaceaRisky$FullMRPMatrix$matrix_1$minimum_values, McGowenRisky$FullMRPMatrix$matrix_1$minimum_values)
CetaceaRisky$FullMRPMatrix$matrix_1$maximum_values <- c(CetaceaRisky$FullMRPMatrix$matrix_1$maximum_values, McGowenRisky$FullMRPMatrix$matrix_1$maximum_values)
CetaceaDangerous$FullMRPMatrix$matrix_1$matrix <- cbind(CetaceaDangerous$FullMRPMatrix$matrix_1$matrix, McGowenDangerous$FullMRPMatrix$matrix_1$matrix[rownames(CetaceaDangerous$FullMRPMatrix$matrix_1$matrix), ])
CetaceaDangerous$FullMRPMatrix$matrix_1$ordering <- c(CetaceaDangerous$FullMRPMatrix$matrix_1$ordering, McGowenDangerous$FullMRPMatrix$matrix_1$ordering)
CetaceaDangerous$FullMRPMatrix$matrix_1$character_weights <- c(CetaceaDangerous$FullMRPMatrix$matrix_1$character_weights, McGowenDangerous$FullMRPMatrix$matrix_1$character_weights)
CetaceaDangerous$FullMRPMatrix$matrix_1$minimum_values <- c(CetaceaDangerous$FullMRPMatrix$matrix_1$minimum_values, McGowenDangerous$FullMRPMatrix$matrix_1$minimum_values)
CetaceaDangerous$FullMRPMatrix$matrix_1$maximum_values <- c(CetaceaDangerous$FullMRPMatrix$matrix_1$maximum_values, McGowenDangerous$FullMRPMatrix$matrix_1$maximum_values)

# Perform STR:
SafeSTR <- SafeTaxonomicReduction(CetaceaSafe$FullMRPMatrix)
RiskySTR <- SafeTaxonomicReduction(CetaceaRisky$FullMRPMatrix)
DangerousSTR <- SafeTaxonomicReduction(CetaceaDangerous$FullMRPMatrix)

# Update STR matrices:
CetaceaSafe$STRMRPMatrix <- SafeSTR$reduced.matrix
CetaceaRisky$STRMRPMatrix <- RiskySTR$reduced.matrix
CetaceaDangerous$STRMRPMatrix <- DangerousSTR$reduced.matrix

# Update STR lists:
CetaceaSafe$SafelyRemovedTaxa <- SafeSTR$str.list
CetaceaRisky$SafelyRemovedTaxa <- RiskySTR$str.list
CetaceaDangerous$SafelyRemovedTaxa <- DangerousSTR$str.list

# Build safe taxonomy tree:
pdf("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Safe/TaxonomyTree.pdf", width = 30, height = 50)
plot(CetaceaSafe$TaxonomyTree, cex = 0.3)
nodelabels(CetaceaSafe$TaxonomyTree$node.label, cex = 0.5)
dev.off()

# Build risky taxonomy tree:
pdf("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Risky/TaxonomyTree.pdf", width = 30, height = 50)
plot(CetaceaRisky$TaxonomyTree, cex = 0.3)
nodelabels(CetaceaRisky$TaxonomyTree$node.label, cex = 0.5)
dev.off()

# Build dangerous taxonomy tree:
pdf("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Dangerous/TaxonomyTree.pdf", width = 30, height = 50)
plot(CetaceaDangerous$TaxonomyTree, cex = 0.3)
nodelabels(CetaceaDangerous$TaxonomyTree$node.label, cex = 0.5)
dev.off()

# Write out safe metatree files:
WriteMorphNexus(CetaceaSafe$FullMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Safe/FULL.nex")
WriteMorphNexus(CetaceaSafe$STRMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Safe/STR.nex")
WriteMorphTNT(CetaceaSafe$FullMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Safe/FULL.tnt")
WriteMorphTNT(CetaceaSafe$STRMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Safe/STR.tnt")
write.table(CetaceaSafe$SafelyRemovedTaxa, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Safe/STR.txt", row.names = FALSE)

# Write out risky metatree files:
WriteMorphNexus(CetaceaRisky$FullMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Risky/FULL.nex")
WriteMorphNexus(CetaceaRisky$STRMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Risky/STR.nex")
WriteMorphTNT(CetaceaRisky$FullMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Risky/FULL.tnt")
WriteMorphTNT(CetaceaRisky$STRMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Risky/STR.tnt")
write.table(CetaceaRisky$SafelyRemovedTaxa, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Risky/STR.txt", row.names = FALSE)

# Write out dangerous metatree files:
WriteMorphNexus(CetaceaDangerous$FullMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Dangerous/FULL.nex")
WriteMorphNexus(CetaceaDangerous$STRMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Dangerous/STR.nex")
WriteMorphTNT(CetaceaDangerous$FullMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Dangerous/FULL.tnt")
WriteMorphTNT(CetaceaDangerous$STRMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Dangerous/STR.tnt")
write.table(CetaceaDangerous$SafelyRemovedTaxa, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Dangerous/STR.txt", row.names = FALSE)

# Add new analysis block to exclude TNT:
SafeSTRTNT <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Safe/STR.tnt")
SafeSTRTNT <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch1.tre;\nbbreak=tbr;\nexport -SafeSTRMPTs.nex;\nproc/;", SafeSTRTNT)
write(SafeSTRTNT, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Safe/STR.tnt")

# Add new analysis block to genus TNT:
RiskySTRTNT <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Risky/STR.tnt")
RiskySTRTNT <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch2.tre;\nbbreak=tbr;\nexport -RiskySTRMPTs.nex;\nproc/;", RiskySTRTNT)
write(RiskySTRTNT, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Risky/STR.tnt")

# Add new analysis block to all TNT:
DangerousSTRTNT <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Dangerous/STR.tnt")
DangerousSTRTNT <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch3.tre;\nbbreak=tbr;\nexport -DangerousSTRMPTs.nex;\nproc/;", DangerousSTRTNT)
write(DangerousSTRTNT, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Dangerous/STR.tnt")
