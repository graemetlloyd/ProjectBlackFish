# SCRIPT TO BUILD METATREE FILES

# Load metatree library:
library(metatree)

# Set directory paths (Spencer, you will want to edit these for your own local version):
MRPDirectory <- "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Input data/MRP"
XMLDirectory <- "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Input data/XML"
MetatreeDirectory <- ""

# Standard exclusive data list (supertrees and the like):
ExclusiveDataList <- c("Averianov_2016a", "Bravo_et_Gaete_2015a", "Brocklehurst_etal_2013a", "Brocklehurst_etal_2015aa", "Brocklehurst_etal_2015ab", "Brocklehurst_etal_2015ac", "Brocklehurst_etal_2015ad", "Brocklehurst_etal_2015ae", "Brocklehurst_etal_2015af", "Bronzati_etal_2012a", "Bronzati_etal_2015ab", "Brusatte_etal_2009ba", "Campbell_etal_2016ab", "Carr_et_Williamson_2004a", "Carr_etal_2017ab", "Frederickson_et_Tumarkin-Deratzian_2014aa", "Frederickson_et_Tumarkin-Deratzian_2014ab", "Frederickson_et_Tumarkin-Deratzian_2014ac", "Frederickson_et_Tumarkin-Deratzian_2014ad", "Garcia_etal_2006a", "Gatesy_etal_2004ab", "Grellet-Tinner_2006a", "Grellet-Tinner_et_Chiappe_2004a", "Grellet-Tinner_et_Makovicky_2006a", "Jin_etal_2010a", "Knoll_2008a", "Kurochkin_1996a", "Lopez-Martinez_et_Vicens_2012a", "Lu_etal_2014aa", "Norden_etal_2018a", "Pisani_etal_2002a", "Ruiz-Omenaca_etal_1997a", "Ruta_etal_2003ba", "Ruta_etal_2003bb", "Ruta_etal_2007a", "Schaeffer_etal_inpressa", "Selles_et_Galobart_2016a", "Sereno_1993a", "Sidor_2001a","Sidor_2003a", "Skutschas_etal_2019a", "Tanaka_etal_2011a", "Toljagic_et_Butler_2013a", "Tsuihiji_etal_2011aa", "Varricchio_et_Jackson_2004a", "Vila_etal_2017a", "Wilson_2005aa", "Wilson_2005ab", "Zelenitsky_et_Therrien_2008a")

# Build exclude cetacean metatree:
CetaceaExclude <- metatree::Metatree(MRPDirectory = MRPDirectory, XMLDirectory = XMLDirectory, TargetClade = "Cetacea", InclusiveDataList = c(), ExclusiveDataList = ExclusiveDataList, MissingSpecies = "exclude", RelativeWeights = c(0, 1, 1, 1), WeightCombination = "product", BackboneConstraint = "McGowen_etal_2009a", ReportContradictionsToScreen = FALSE)

# Build genus cetacean metatree:
CetaceaGenus <- metatree::Metatree(MRPDirectory = MRPDirectory, XMLDirectory = XMLDirectory, TargetClade = "Cetacea", InclusiveDataList = c(), ExclusiveDataList = ExclusiveDataList, MissingSpecies = "genus", RelativeWeights = c(0, 1, 1, 1), WeightCombination = "product", BackboneConstraint = "McGowen_etal_2009a", ReportContradictionsToScreen = FALSE)

# Build all cetacean metatree:
CetaceaAll <- metatree::Metatree(MRPDirectory = MRPDirectory, XMLDirectory = XMLDirectory, TargetClade = "Cetacea", InclusiveDataList = c(), ExclusiveDataList = ExclusiveDataList, MissingSpecies = "all", RelativeWeights = c(0, 1, 1, 1), WeightCombination = "product", BackboneConstraint = "McGowen_etal_2009a", ReportContradictionsToScreen = FALSE)

# Build exclude taxonomy tree:
pdf("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Exclude/TaxonomyTree.pdf", width = 30, height = 50)
plot(CetaceaExclude$TaxonomyTree, cex = 0.3)
nodelabels(CetaceaExclude$TaxonomyTree$node.label, cex = 0.5)
dev.off()

# Build genus taxonomy tree:
pdf("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Genus/TaxonomyTree.pdf", width = 30, height = 50)
plot(CetaceaGenus$TaxonomyTree, cex = 0.3)
nodelabels(CetaceaGenus$TaxonomyTree$node.label, cex = 0.5)
dev.off()

# Build all taxonomy tree:
pdf("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/All/TaxonomyTree.pdf", width = 30, height = 50)
plot(CetaceaAll$TaxonomyTree, cex = 0.3)
nodelabels(CetaceaAll$TaxonomyTree$node.label, cex = 0.5)
dev.off()

# Write out exclude metatree files:
WriteMorphNexus(CetaceaExclude$FullMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Exclude/FULL.nex")
WriteMorphNexus(CetaceaExclude$STRMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Exclude/STR.nex")
WriteMorphTNT(CetaceaExclude$FullMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Exclude/FULL.tnt")
WriteMorphTNT(CetaceaExclude$STRMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Exclude/STR.tnt")
write.table(CetaceaExclude$SafelyRemovedTaxa, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Exclude/STR.txt", row.names = FALSE)

# Write out genus metatree files:
WriteMorphNexus(CetaceaGenus$FullMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Genus/FULL.nex")
WriteMorphNexus(CetaceaGenus$STRMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Genus/STR.nex")
WriteMorphTNT(CetaceaGenus$FullMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Genus/FULL.tnt")
WriteMorphTNT(CetaceaGenus$STRMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Genus/STR.tnt")
write.table(CetaceaGenus$SafelyRemovedTaxa, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Genus/STR.txt", row.names = FALSE)

# Write out all metatree files:
WriteMorphNexus(CetaceaAll$FullMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/All/FULL.nex")
WriteMorphNexus(CetaceaAll$STRMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/All/STR.nex")
WriteMorphTNT(CetaceaAll$FullMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/All/FULL.tnt")
WriteMorphTNT(CetaceaAll$STRMRPMatrix, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/All/STR.tnt")
write.table(CetaceaAll$SafelyRemovedTaxa, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/All/STR.txt", row.names = FALSE)

# Add new analysis block to exclude TNT:
ExcludeSTRTNT <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Exclude/STR.tnt")
ExcludeSTRTNT <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch1.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch1.tre;\nbbreak=tbr;\nexport -ExcludeSTRMPTs.nex;\nproc/;", ExcludeSTRTNT)
write(ExcludeSTRTNT, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Exclude/STR.tnt")

# Add new analysis block to genus TNT:
GenusSTRTNT <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Genus/STR.tnt")
GenusSTRTNT <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch2.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch2.tre;\nbbreak=tbr;\nexport -GenusSTRMPTs.nex;\nproc/;", GenusSTRTNT)
write(GenusSTRTNT, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Genus/STR.tnt")

# Add new analysis block to all TNT:
AllSTRTNT <- readLines("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/All/STR.tnt")
AllSTRTNT <- gsub("proc/;", "rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch3.tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch3.tre;\nbbreak=tbr;\nexport -AllSTRMPTs.nex;\nproc/;", AllSTRTNT)
write(AllSTRTNT, "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/All/STR.tnt")
