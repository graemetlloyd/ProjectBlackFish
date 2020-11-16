rm(list=ls())
library(coda)


setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/Risky/")
log1 <- read.table("Cetacea_Risky-1601692602937.log", header=T, stringsAsFactors = F, row.names = 1)
log2 <- read.table("Cetacea_Risky-1601861322877.log", header=T, stringsAsFactors = F, row.names = 1)
head(log1)
par(mfrow=c(1,1))
plot(rownames(log1)[-(1:101)], log1$likelihood[-(1:101)], type="l", col="red")
lines(rownames(log2)[-(1:101)], log2$likelihood[-(1:101)], col="blue")

log1mcmc<-mcmc(data= log1, start = 0, end = 100000000, thin = 100000)
log2mcmc<-mcmc(data= log2, start = 0, end = 100000000, thin = 100000)

comb.mcmc<-mcmc.list(log1mcmc, log2mcmc)

gelman.diag(comb.mcmc, multivariate = FALSE, autoburnin = F)

log1<- log1[-(1:401),]
log2<- log2[-(1:251),]
log<-rbind(log1,log2)

rm(list=c("log1", "log2"))

library(ape)
tree1 <- read.nexus("Cetacea_Risky-1601692602937.trees")[-(1:401)] 
tree2 <- read.nexus("Cetacea_Risky-1601861322877.trees")[-(1:251)] 

trees <- append(tree1,tree2)
rm(list=c("tree1", "tree2"))

write.tree(trees,"Cetacea_Risky_posterior.trees")

MAP <- trees[[which.max(log$posterior)]]
write.tree(MAP, "Cetacea_Risky_MAP.tree")

fossils<-setdiff(MAP$tip.label, dropExtinct(MAP)$tip.label)
extant <- lapply(trees, drop.tip, tip=fossils )
class(extant) <- "multiPhylo"
write.tree(extant, file="Cetacea_Risky_Extant_Posterior.trees")
