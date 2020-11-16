library(paleobioDB)
library(metatree)
library(BAMMtools)
library(metatree)
setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/fossilBAMM/")
## safe
safe<-read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/Safe/Safe_MAP.tre")
safe$tip.label
x <-ladderize(drop.tip(safe, safe$tip.label[447:487])) # remove non-neocetes


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
write.tree(x2, "~/Dropbox/bamm_whales/safe_crowngroup_noanc.tre")
ntax <- length(x2$tip.label)
BAMMtools::setBAMMpriors(x2, outfile="safe.priors.txt")
rm(list=ls())


## Risky tree ##
risky<-read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/Risky/Cetacea_Risky_MAP.tree")
risky$tip.label
x<-ladderize(drop.tip(risky, risky$tip.label[550:601]))
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
write.tree(x2, "Risky/risky_crowngroup_noanc.tre")
ntax <- length(x2$tip.label)
BAMMtools::setBAMMpriors(x2, outfile="Risky/risky.priors.txt")
rm(list=ls())


## dangerous taxa tree ##
dangerous<-read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/TimeTreeInference/Dangerous/Cetacea_Dangerous_MAP.tree")
 dangerous$tip.label
x<-ladderize(drop.tip(dangerous, dangerous$tip.label[652:719]))
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
write.tree(x2, "Dangerous/Dangerous_crowngroup_noanc.tre")
ntax <- length(x2$tip.label)
BAMMtools::setBAMMpriors(x2, outfile="Dangerous/Dangerous.priors.txt")
rm(list=ls())
