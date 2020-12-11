setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/fossilBAMM/Safe/")

library(BAMMtools)
library(coda)

bamm_gelman <- function(run1, run2, gens=9990000,thin=10000) {
  
  res <- matrix(data=unlist(run1$tipLambda), nrow=length(run1$tipLambda), ncol=length(run1$tipLambda[[1]]),byrow = T)
  res2 <- matrix(data=unlist(run2$tipLambda), nrow=length(run2$tipLambda), ncol=length(run2$tipLambda[[1]]),byrow = T)
  
  log1mcmc<-mcmc(data= res, start = 0, end = gens, thin = thin)
  log2mcmc<-mcmc(data= res2, start = 0, end = gens, thin = thin)
  
  comb.mcmc<-mcmc.list(log1mcmc, log2mcmc)
  
  gelman.diag(comb.mcmc, multivariate = FALSE, autoburnin = F) # Ok!
  
}


tree <- read.tree("safe_crowngroup_noanc.tre")
edata1 <- getEventData(tree, eventdata = "safe_event_data.txt", burnin = 0)
edata2 <- getEventData(tree, eventdata = "run1/safe_event_data.txt", burnin = 0)

bamm_gelman(edata1, edata2)

setwd("..")

tree <- read.tree("Risky/risky_crowngroup_noanc.tre")
edata1 <- getEventData(tree, eventdata = "Risky/risky_event_data.txt", burnin = 0)
edata2 <- getEventData(tree, eventdata = "Risky/run2/risky_event_data.txt", burnin = 0)

bamm_gelman(edata1, edata2)


setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/fossilBAMM/")
tree <- read.tree("Dangerous/DaNngerous_crowngroup_noanc.tre")
edata1 <- getEventData(tree, eventdata = "Dangerous/Dangerous_event_data.txt", burnin = 0)
edata2 <- getEventData(tree, eventdata = "Dangerous/run2/Dangerous_event_data.txt", burnin = 0)

bamm_gelman(edata1, edata2)

