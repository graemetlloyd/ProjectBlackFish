phy<-read.nexus("~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/Genus/Genus_combined.trees")
phy2 <-lapply(phy, drop.fossil)
class(phy2) <- class(phy)
write.tree(phy2, "~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/Genus/genus_extant.trees")


phy<-read.nexus("~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/ALL/combined.trees")
phy2 <-lapply(phy, drop.fossil)
class(phy2) <- class(phy)
write.tree(phy2, "~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/ALL/all_extant.trees")


#### 

library(phyloch)
extant <- read.beast("~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/EXCLUDE/extantmcc.tre")
genus <- read.beast("~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/Genus/genus_extant_mcc.tre")
all <- read.beast("~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/ALL/all_extant_mcc.tre")


get.node.ages <- function(phy, tip1, tip2, age = c("height","height_median")) {
  age <- match.arg(age,  c("height","height_median"))
  ntips <-length(phy$tip.label)
  ca<- getMRCA(phy, c(tip1, tip2)) - ntips
  paste(round(phy[[age]][ca], 1), " (",round(phy[["height_95%_HPD_MAX"]][ca], 1), " - ", round(phy[["height_95%_HPD_MIN"]][ca], 1), ")", sep="")
}

output1 <- file("~/Desktop/nodeages.txt", "w")  

#crown
writeLines(paste("Crown group",
get.node.ages(extant, "Balaena_mysticetus", "Orcinus_orca"),
get.node.ages(genus, "Balaena_mysticetus", "Orcinus_orca"),
get.node.ages(all, "Balaena_mysticetus", "Orcinus_orca")),
, con = output1, sep = "\t")
cat("\n", file = output1)
close(output1)
#mysticetes
get.node.ages(extant, "Balaena_mysticetus", "Balaenoptera_musculus")
get.node.ages(genus, "Balaena_mysticetus", "Balaenoptera_musculus")
get.node.ages(all, "Balaena_mysticetus", "Balaenoptera_musculus")

# balaenidae
get.node.ages(extant, "Balaena_mysticetus", "Eubalaena_glacialis")
get.node.ages(genus, "Balaena_mysticetus", "Eubalaena_glacialis")
get.node.ages(all, "Balaena_mysticetus", "Eubalaena_glacialis")

# Balaenopteridae
get.node.ages(extant, "Balaenoptera_musculus", "Balaenoptera_acutorostrata")
get.node.ages(genus, "Balaenoptera_musculus", "Balaenoptera_acutorostrata")
get.node.ages(all, "Balaenoptera_musculus", "Balaenoptera_acutorostrata")


# Odontoceti
get.node.ages(extant, "Physeter_macrocephalus", "Orcinus_orca")
get.node.ages(genus, "Physeter_macrocephalus", "Orcinus_orca")
get.node.ages(all, "Physeter_macrocephalus", "Orcinus_orca")

# Physteridae
get.node.ages(extant, "Physeter_macrocephalus", "Kogia_breviceps")
get.node.ages(genus, "Physeter_macrocephalus", "Kogia_breviceps")
get.node.ages(all, "Physeter_macrocephalus", "Kogia_breviceps")

# Physteridae
get.node.ages(extant, "Physeter_macrocephalus", "Kogia_breviceps")
get.node.ages(genus, "Physeter_macrocephalus", "Kogia_breviceps")
get.node.ages(all, "Physeter_macrocephalus", "Kogia_breviceps")

# Delphinidae
get.node.ages(extant, "Delphinus_capensis", "Orcinus_orca")
get.node.ages(genus, "Delphinus_capensis", "Orcinus_orca")
get.node.ages(all, "Delphinus_capensis", "Orcinus_orca")

# Delphinidae
get.node.ages(extant, "Delphinus_capensis", "Orcinus_orca")
get.node.ages(genus, "Delphinus_capensis", "Orcinus_orca")
get.node.ages(all, "Delphinus_capensis", "Orcinus_orca")
