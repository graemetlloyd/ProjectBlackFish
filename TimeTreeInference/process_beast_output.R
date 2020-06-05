setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/ALL/")
log1 <- read.table("Cetacea_ALL-1585538507944.log", header=T)
log2 <- read.table("Cetacea_ALL-1585538507944.log", header=T)

# the hightest posterior prob
which.max(c(log1$posterior[which.max(log1$posterior)], 
  log2$posterior[which.max(log2$posterior)]))

map <- read.nexus("Cetacea_ALL-1585538507944.trees")[[which.max(log1$posterior)]]
write.tree(ladderize(map), "ALL_MAP.tre")

### get extant tree ##
burnin <- 0.1

trees1<-read.nexus("Cetacea_ALL-1585538507944.trees")
trees2<-read.nexus("Cetacea_ALL-1585538507944.trees")

keep<-seq(ceiling(burnin*length(trees2)), length(trees1))

posterior <- append(trees1[keep], trees2[keep])

extant<-lapply(posterior, drop.fossil)
class(extant) <- class(trees1)
write.tree(extant, "ALL_EXTANT_POSTERIOR.trees")
