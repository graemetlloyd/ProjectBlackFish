library(coda)

setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/Safe/")
log1 <- read.table("Cetacea_Safe-1601411220948.log", header=T, stringsAsFactors = F, row.names = 1)
log2 <- read.table("Cetacea_Safe-1601427020802.log", header=T, stringsAsFactors = F, row.names = 1)
head(log1)


log1mcmc<-mcmc(data= log1, start = 0, end = 100000000, thin = 100000)
log2mcmc<-mcmc(data= log2, start = 0, end = 100000000, thin = 100000)

comb.mcmc<-mcmc.list(log1mcmc, log2mcmc)

gelman.diag(comb.mcmc, multivariate = FALSE, autoburnin = T)

burnin <- ceiling(0.25 *nrow(log1))

log1<- log1[-(1:burnin),]
log2<- log2[-(1:burnin),]

log<-rbind(log1,log2)
rm(list=c("log1", "log2"))
str(log)
library(ape)
tree1 <- read.nexus("Cetacea_Safe-1601411220948.trees")[-(1:burnin)] 
tree2 <- read.nexus("Cetacea_Safe-1601427020802.trees")[-(1:burnin)] 

trees <- append(tree1,tree2)
rm(list=c("tree1", "tree2"))

write.tree(trees,"Cetacea_Safe_posterior.trees")

MAP <- trees[[which.max(log$posterior)]]
write.tree(MAP, "Cetacea_Safe_MAP.tree")

fossils<-setdiff(MAP$tip.label, dropExtinct(MAP)$tip.label)
extant <- lapply(trees, drop.tip, tip=fossils )
class(extant) <- "multiPhylo"
write.tree(extant, file="Cetacea_Safe_Extant_Posterior.trees")
