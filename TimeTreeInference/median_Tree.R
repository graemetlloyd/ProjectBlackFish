library(treespace)
rm(list=ls())
trees <- read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/Safe/Cetacea_Safe_posterior.trees")

length(trees)

KCdist05 <- multiDist(trees, lambda=0.5)

d<-matrix(data=NA, nrow=1500, ncol=1500)
d[lower.tri(d, diag = F)] <- KCdist05
d<-t(d)
d[lower.tri(d)] <- t(d)[(lower.tri(d))]
diag(d) <- rep(0,length(trees))
median.tree05<-trees[[which.min(colSums(d))]] #378
write.tree(median.tree05, "~/Desktop/median_safe.tre")

### risky ###
rm(list=ls())
trees <- read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/Risky/Cetacea_Risky_posterior.trees")
length(trees)
KCdist05 <- multiDist(trees, lambda=0.5)
d<-matrix(data=NA, nrow=1350, ncol=1350)
d[lower.tri(d, diag = F)] <- KCdist05
d<-t(d)
d[lower.tri(d)] <- t(d)[(lower.tri(d))]
diag(d) <- rep(0,length(trees))
median.tree05<- trees[[which.min(colSums(d))]]
write.tree(median.tree05, "~/Desktop/median_risky.tre")

### risky ###
rm(list=ls())
trees <- read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/Dangerous/Cetacea_Dangerous_posterior.trees")
trees<-trees[seq(1,length(trees), 2)] # downsample every other tree
length(trees)
KCdist05 <- multiDist(trees, lambda=0.5)
d<-matrix(data=NA, nrow=1367, ncol=1367)
d[lower.tri(d, diag = F)] <- KCdist05
d<-t(d)
d[lower.tri(d)] <- t(d)[(lower.tri(d))]

diag(d) <- rep(0, 1367)
median.tree05<- trees[[which.min(colSums(d))]]
write.tree(median.tree05, "~/Desktop/median_dangerous.tre")
