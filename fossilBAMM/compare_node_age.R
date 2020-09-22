phy<-read.nexus("~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/Risky/Risky_combined.trees")
phy2 <-lapply(phy, drop.fossil)
class(phy2) <- class(phy)
write.tree(phy2, "~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/Risky/risky_extant.trees")


phy<-read.nexus("~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/Dangerous/combined.trees")
phy2 <-lapply(phy, drop.fossil)
class(phy2) <- class(phy)
write.tree(phy2, "~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/Dangerous/dangerous_extant.trees")


#### 

library(phyloch)
safe <- read.beast("~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/Safe/extantmcc.tre")
risky <- read.beast("~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/Risky/risky_extant_mcc.tre")
dangerous <- read.beast("~/Dropbox/Mammal_Supertree/BEAST_ANALYSIS/Dangerous/dangerous_extant_mcc.tre")


get.node.ages <- function(phy, tip1, tip2, age = c("height","height_median")) {
  age <- match.arg(age,  c("height","height_median"))
  ntips <-length(phy$tip.label)
  ca<- getMRCA(phy, c(tip1, tip2)) - ntips
  paste(round(phy[[age]][ca], 1), " (",round(phy[["height_95%_HPD_MAX"]][ca], 1), " - ", round(phy[["height_95%_HPD_MIN"]][ca], 1), ")", sep="")
}

output1 <- file("~/Desktop/nodeages.txt", "w")  

#crown
writeLines(paste("Crown group",
get.node.ages(safe, "Balaena_mysticetus", "Orcinus_orca"),
get.node.ages(risky, "Balaena_mysticetus", "Orcinus_orca"),
get.node.ages(dangerous, "Balaena_mysticetus", "Orcinus_orca")),
, con = output1, sep = "\t")
cat("\n", file = output1)
close(output1)
#mysticetes
get.node.ages(safe, "Balaena_mysticetus", "Balaenoptera_musculus")
get.node.ages(risky, "Balaena_mysticetus", "Balaenoptera_musculus")
get.node.ages(dangerous, "Balaena_mysticetus", "Balaenoptera_musculus")

# balaenidae
get.node.ages(safe, "Balaena_mysticetus", "Eubalaena_glacialis")
get.node.ages(risky, "Balaena_mysticetus", "Eubalaena_glacialis")
get.node.ages(dangerous, "Balaena_mysticetus", "Eubalaena_glacialis")

# Balaenopteridae
get.node.ages(safe, "Balaenoptera_musculus", "Balaenoptera_acutorostrata")
get.node.ages(risky, "Balaenoptera_musculus", "Balaenoptera_acutorostrata")
get.node.ages(dangerous, "Balaenoptera_musculus", "Balaenoptera_acutorostrata")


# Odontoceti
get.node.ages(safe, "Physeter_macrocephalus", "Orcinus_orca")
get.node.ages(risky, "Physeter_macrocephalus", "Orcinus_orca")
get.node.ages(dangerous, "Physeter_macrocephalus", "Orcinus_orca")

# Physteridae
get.node.ages(safe, "Physeter_macrocephalus", "Kogia_breviceps")
get.node.ages(risky, "Physeter_macrocephalus", "Kogia_breviceps")
get.node.ages(dangerous, "Physeter_macrocephalus", "Kogia_breviceps")

# Physteridae
get.node.ages(safe, "Physeter_macrocephalus", "Kogia_breviceps")
get.node.ages(risky, "Physeter_macrocephalus", "Kogia_breviceps")
get.node.ages(dangerous, "Physeter_macrocephalus", "Kogia_breviceps")

# Delphinidae
get.node.ages(safe, "Delphinus_capensis", "Orcinus_orca")
get.node.ages(risky, "Delphinus_capensis", "Orcinus_orca")
get.node.ages(dangerous, "Delphinus_capensis", "Orcinus_orca")

# Delphinidae
get.node.ages(safe, "Delphinus_capensis", "Orcinus_orca")
get.node.ages(risky, "Delphinus_capensis", "Orcinus_orca")
get.node.ages(dangerous, "Delphinus_capensis", "Orcinus_orca")
