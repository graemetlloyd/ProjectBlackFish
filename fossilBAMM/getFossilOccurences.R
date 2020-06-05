library(paleobioDB)
library(metatree)
library(BAMMtools)
setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/fossilBAMM/")
## exclude 
exclude<-read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/EXCLUDE/Exclude_MAP.tre")
exclude$tip.label
x <-ladderize(drop.tip(exclude, exclude$tip.label[447:487])) # remove non-neocetes


pbdb.query<-list()
for(i in 1:length(x$tip.label)) {
  tryCatch( {
    pbdb.query[[i]] <- pbdb_occurrences(taxon_name = gsub(pattern = "_",replacement = " ", x = x$tip.label[i]))
  }, error = function(e){}
  )
}
no.occur<-length(which(unlist(lapply(pbdb.query, is.null ))==TRUE))
occur<-unlist(lapply(pbdb.query, nrow))
sum(c(occur, no.occur))

# drop sampled ancestors #

x2 <- drop.tip(x,x$tip.label[x$edge[which(x$edge.length==0),2]])
write.tree(x2, "~/Dropbox/bamm_whales/exclude_crowngroup_noanc.tre")
ntax <- length(x2$tip.label)
BAMMtools::setBAMMpriors(x2, outfile="exclude.priors.txt")
rm(list=ls())
## Genus tree ##
genus<-read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/GENUS/GENUS_MAP.tre")
genus$tip.label
x<-ladderize(drop.tip(genus, genus$tip.label[543:590]))
pbdb.query<-list()
for(i in 1:length(x$tip.label)) {
  tryCatch( {
    pbdb.query[[i]] <- pbdb_occurrences(taxon_name = gsub(pattern = "_",replacement = " ", x = x$tip.label[i]))
  }, error = function(e){}
  )
}
no.occur<-length(which(unlist(lapply(pbdb.query, is.null ))==TRUE))
occur<-unlist(lapply(pbdb.query, nrow))
sum(c(occur, no.occur))

x2 <- drop.tip(x,x$tip.label[x$edge[which(x$edge.length==0),2]])
write.tree(x2, "genus_crowngroup_noanc.tre")
ntax <- length(x2$tip.label)
BAMMtools::setBAMMpriors(x2, outfile="genus.priors.txt")
rm(list=ls())


## all taxa tree ##
# all<-read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/ALL/ALL_MAP.tre")
# all$tip.label
# x<-ladderize(drop.tip(all, all$tip.label[620:682]))
# pbdb.query<-list()
# for(i in 1:length(x$tip.label)) {
#   tryCatch( {
#     pbdb.query[[i]] <- pbdb_occurrences(taxon_name = gsub(pattern = "_",replacement = " ", x = x$tip.label[i]))
#   }, error = function(e){}
#   )
# }
# no.occur<-length(which(unlist(lapply(pbdb.query, is.null ))==TRUE))
# occur<-unlist(lapply(pbdb.query, nrow))
# sum(c(occur, no.occur))
# x <- read.tree("~/Dropbox/bamm_whales/crown.map_all.tre")
# BAMMtools::setBAMMpriors(x, total.taxa=619, outfile="~/Dropbox/bamm_whales/all.priors.txt")
# 
