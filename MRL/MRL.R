setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/MRL/")
rm(list=ls())
library(ape)
tre <- read.tree("DangerousSTRMPTs.tre")
contre<-multi2di(consensus(tre, p=0.5))

library("Claddis")

nex<-ReadMorphNexus("STR.nex")
write.csv(t(round(nex$Matrix_1$Weights, 0)), file="Dangerous_MRL_weights.txt", quote = F,row.names = F)

nex <- read.nexus.data("STR.nex")

nchar <- length(nex[[1]])
switch<-sort(sample(x=1:nchar, size = nchar/2, replace = F))

repl.code<-function(x) {
  if(x==1) return(0)
  if(x==0) return(1)
  if(x=="?") return("?")
}

for(i in 1:length(nex)) {
  for(j in 1:length(switch)){
    nex[[i]][j] <- repl.code(nex[[i]][j])
  } 
}

write.nexus.data(nex,"Dangerous_MRL.nex", interleaved = F)  
setdiff(names(nex), contre$tip.label)
contre$tip.label[grep("Balaenopteridae_indet_aka_portisi_MRSN_PU13808_et_MGPT_13803_et_MCZ_17882_et_SDSNH_21507_et_65769_et_6869", contre$tip.label)] <- "Balaenopteridae_indet_aka_portisi_MRSN_PU13808_et_MGPT_13803_et_MCZ_17882_et_SDSNH_21507_et_65769_et_68698" 
write.tree(contre, "Dangerous_MRL_start.tre")

### reinsert ###

safe_taxonomic_reinsertion(input_filename = "RAxML_result.Dangerous_MRL", output_filename = "Dangerous_MRL_reinsert.tre", str_taxa = read.table("STR.txt", header = TRUE, stringsAsFactors = FALSE), multiple_placement_option  = "random")
?Claddis
