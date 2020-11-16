setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/fossilBAMM/Dangerous/")

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


dangeroustree <- read.tree("Dangerous_crowngroup_noanc.tre")
dangerous.edata1 <- getEventData(dangeroustree, eventdata = "Dangerous_event_data.txt", burnin = 0)
dangerous.edata2 <- getEventData(dangeroustree, eventdata = "Dangerous_run2_event_data.txt", burnin = 0)

bamm_gelman(dangerous.edata1, dangerous.edata2)

dangerous.mcmcout <- read.csv("Dangerous_mcmc_out.txt", header = TRUE)
burnstart <- floor(0.1 * nrow(dangerous.mcmcout))
dangerous.postburn <- dangerous.mcmcout[burnstart:nrow(dangerous.mcmcout), ]
plot(dangerous.postburn$logLik ~ dangerous.postburn$generation, type = "l")

## check effective sample sizes ## 
apply(dangerous.postburn, 2, effectiveSize)

## check effective sample sizes ## 
effectiveSize(dangerous.postburn$N_shifts)
effectiveSize(dangerous.postburn$logLik)



dangerous.mcmcout1$generation
