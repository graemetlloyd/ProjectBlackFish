library(BAMMtools)
library(coda)
rm(list=ls())
setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/fossilBAMM/")
list.files()

## exclude tree ##
excludetree <- read.tree("exclude_crowngroup_noanc.tre")
exclude.edata <- getEventData(excludetree, eventdata = "exclude_event_data.txt", burnin=0.1)
exclude.mcmcout <- read.csv("exclude_mcmc_out.txt", header=T)
plot(exclude.mcmcout$logLik ~ exclude.mcmcout$generation, type="l")

burnstart <- floor(0.05 * nrow(exclude.mcmcout))
exclude.postburn <- exclude.mcmcout[burnstart:nrow(exclude.mcmcout), ]
plot(exclude.postburn$logLik ~ exclude.postburn$generation, type="l")

## check effective sample sizes ## 
effectiveSize(exclude.postburn$N_shifts)
effectiveSize(exclude.postburn$logLik)

## table of posterior probabilities for shifts ##
## store all in a table
shift_prob_table <- matrix(data=NA, ncol=3, nrow=12)
shift_probs <- summary(exclude.edata)
shift_prob_table[shift_probs[,1]+1,1] <- shift_probs[,2]
# 3 or 4 shifts best supported (pp = 0.29. 0.22), with 0 shifts weakly supported (pp = 0.0011)
exclude.css <- credibleShiftSet(exclude.edata, expectedNumberOfShifts=1, threshold=5, set.limit = 0.95)

exclude.css$number.distinct ## 483 distinct configurations
summary(exclude.css) ## first 9 contain 2-4 shifts and explain 0.22 cum. prob.

pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/ExcludeCredibleSetSpec.pdf", height=7, width=7)
plot.credibleshiftset(exclude.css, spex="s")
dev.off()
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/ExcludeCredibleSetExt.pdf", height=7, width=7)
plot.credibleshiftset(exclude.css, spex="e")
dev.off()
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/ExcludeCredibleSetNetDiv.pdf", height=7, width=7)
plot.credibleshiftset(exclude.css, spex="netdiv")
dev.off()
## include shifts in Ziphiidae, delphinidae, and rorquals

exclude.bfmat <- computeBayesFactors(exclude.postburn, expectedNumberOfShifts=1, burnin=0)
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/Exclude_best_config.pdf", height=4, width=7)
par(mfrow=c(1,3), mar=c(4,4,1,1))
bp <- getBestShiftConfiguration(exclude.edata, expectedNumberOfShift=1, threshold = 5)
exclude.phylorates<-plot.bammdata(bp, lwd=1,legend=T, spex="s")
#addBAMMshifts(bp, cex=2)
exclude.phylorates<-plot.bammdata(bp, lwd=1,legend=T, spex="e")
#addBAMMshifts(bp, cex=2)
exclude.phylorates<-plot.bammdata(bp, lwd=1,legend=T, spex="netdiv")
#addBAMMshifts(bp, cex=2)
dev.off()

## genus tree ##
genustree <- read.tree("GENUS/genus_crowngroup_noanc.tre")
genus.edata <- getEventData(genustree, eventdata = "GENUS/genus_event_data.txt", burnin=0.1)
genus.mcmcout <- read.csv("GENUS/genus_mcmc_out.txt", header=T)
plot(genus.mcmcout$logLik ~ genus.mcmcout$generation, type="l")

burnstart <- floor(0.05 * nrow(genus.mcmcout))
genus.postburn <- genus.mcmcout[burnstart:nrow(genus.mcmcout), ]
plot(genus.postburn$logLik ~ genus.postburn$generation, type="l")

## check effective sample sizes ## 
effectiveSize(genus.postburn$N_shifts)
effectiveSize(genus.postburn$logLik)

## table of posterior probabilities for shifts ##
shift_probs <- summary(genus.edata) # 1 shift = 0.51, 2 shofts = 0.36
shift_prob_table[shift_probs[,1]+1,2] <- shift_probs[,2]

genus.css <- credibleShiftSet(genus.edata, expectedNumberOfShifts=1, threshold=5, set.limit = 0.95)
genus.css$number.distinct ## 83 distinct configurations
summary(genus.css)
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/GenusCredibleSetSpec.pdf", height=7, width=7)
plot.credibleshiftset(genus.css, spex="s")
dev.off()
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/GenusCredibleSetExt.pdf", height=7, width=7)
plot.credibleshiftset(genus.css, spex="e")
dev.off()
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/GenusCredibleSetNetDiv.pdf", height=7, width=7)
plot.credibleshiftset(genus.css, spex="netdiv")
dev.off()
## top nine configurations (cumulative 87% of prob) 
## include shifts in Ziphiidae, delphinidae, and rorquals

genus.bfmat <- computeBayesFactors(genus.postburn, expectedNumberOfShifts=1, burnin=0)
bp <- getBestShiftConfiguration(genus.edata, expectedNumberOfShift=1, threshold = 5)
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/Genus_best_config.pdf", height=4, width=7)
par(mfrow=c(1,3), mar=c(4,4,1,1))
plot.bammdata(bp, lwd=1,legend=T, spex="s")
plot.bammdata(bp, lwd=1,legend=T, spex="e")
plot.bammdata(bp, lwd=1,legend=T, spex="netdiv")
dev.off()


## all tree ##
alltree <- read.tree("ALL/all_crowngroup_noanc.tre")
all.edata <- getEventData(alltree, eventdata = "ALL/all_event_data.txt", burnin=0.1)
all.mcmcout <- read.csv("ALL/all_mcmc_out.txt", header=T)
plot(all.mcmcout$logLik ~ all.mcmcout$generation, type="l")

burnstart <- floor(0.05 * nrow(all.mcmcout))
all.postburn <- all.mcmcout[burnstart:nrow(all.mcmcout), ]
plot(all.postburn$logLik ~ all.postburn$generation, type="l")

## check effective sample sizes ## 
effectiveSize(all.postburn$N_shifts)
effectiveSize(all.postburn$logLik)

## table of posterior probabilities for shifts ##
shift_probs <- summary(all.edata)
shift_prob_table[shift_probs[,1]+1,3] <- shift_probs[,2]
rownames(shift_prob_table) <- seq(0, 11)
colnames(shift_prob_table) <- c("Exclude", "Genus","All")
write.csv(shift_prob_table, file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/ShiftProbTable.csv" )

#0 shifts best supported (pp = 0.4600), with 1 shifts well supported (pp = 0.23)
all.css <- credibleShiftSet(all.edata, expectedNumberOfShifts=1, threshold=5, set.limit = 0.95)
all.css$number.distinct ## 155 distinct configurations
summary(all.css)

pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/AllCredibleSetSpec.pdf", height=7, width=7)
plot.credibleshiftset(all.css, spex="s")
dev.off()
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/AllCredibleSetExt.pdf", height=7, width=7)
plot.credibleshiftset(all.css, spex="e")
dev.off()
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/AllCredibleSetNetDiv.pdf", height=7, width=7)
plot.credibleshiftset(all.css, spex="netdiv")
dev.off()


bp <- getBestShiftConfiguration(all.edata, expectedNumberOfShift=1, threshold = 5)


## plot all results ##
pdf(file = "~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/ratesthrutime.pdf", width = 7, height=7)
par(mfcol=c(3,3), xpd=F)
plotRateThroughTime(exclude.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "auto", smooth=TRUE, avgCol = "black", intervalCol = "gray", ylim=c(0.1,0.4), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd=NA); text(51, 0.45, labels = "A.", font=1, cex=1.5); par(xpd=F)
plotRateThroughTime(exclude.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "extinction", smooth=TRUE, avgCol = "black", intervalCol = "gray", ylim=c(0.1,0.4), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd=NA); text(51, 0.45, labels = "B.", font=1, cex=1.5); par(xpd=F)
plotRateThroughTime(exclude.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "netdiv", smooth=TRUE, avgCol = "black", intervalCol = "gray", ylim=c(-0.1,0.12), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd=NA); text(51, 0.15, labels = "C.", font=1, cex=1.5); par(xpd=F)

plotRateThroughTime(genus.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "auto", smooth=TRUE, avgCol = "black", intervalCol = "gray", ylim=c(0.1,0.4), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd=NA); text(51, 0.45, labels = "D.", font=1, cex=1.5); par(xpd=F)
plotRateThroughTime(genus.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "extinction", smooth=TRUE, avgCol = "black", intervalCol = "gray", ylim=c(0.1,0.4), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd=NA); text(51, 0.45, labels = "E.", font=1, cex=1.5); par(xpd=F)
plotRateThroughTime(genus.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "netdiv", smooth=TRUE, avgCol = "black", intervalCol = "gray", ylim=c(-0.1,0.12), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd=NA); text(51, 0.15, labels = "F.", font=1, cex=1.5); par(xpd=F)

plotRateThroughTime(all.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "auto", smooth=TRUE, avgCol = "black", intervalCol = "gray", ylim=c(0.1,0.4), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd=NA); text(51, 0.45, labels = "G.", font=1, cex=1.5); par(xpd=F)
plotRateThroughTime(all.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "extinction", smooth=TRUE, avgCol = "black", intervalCol = "gray", ylim=c(0.1,0.4), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd=NA); text(51, 0.45, labels = "H.", font=1, cex=1.5); par(xpd=F)
plotRateThroughTime(all.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "netdiv", smooth=TRUE, avgCol = "black", intervalCol = "gray", ylim=c(-0.1,0.12), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd=NA); text(51, 0.15, labels = "I.", font=1, cex=1.5); par(xpd=F)
dev.off()




## plot all results ##
pdf(file = "~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/meanrates.pdf", width = 7, height=7)

par(mfcol=c(3,3), xpd=F)
es<-plot.bammdata(exclude.edata, spex="s", breaksmethod="linear", lwd=0.75, tau=0.01, labels=F,mar = c(4,3,1,1))
addBAMMlegend(es, location = c(-1, 1, 20, 120), cex.axis=0.7, labelDist=0.35, tck=-0.005); axisPhylo()
ee<-plot.bammdata(exclude.edata, spex="e", breaksmethod="linear", lwd=0.75, tau=0.01, labels=F)
addBAMMlegend(ee, location = c(-1, 1, 20, 120), cex.axis=0.7, labelDist=0.35, tck=-0.005); axisPhylo()
ed<-plot.bammdata(exclude.edata, spex="netdiv", breaksmethod="linear", lwd=0.75, tau=0.01, labels=F)
addBAMMlegend(ed, location = c(-1, 1, 20, 120), cex.axis=0.7, labelDist=0.35, tck=-0.005); axisPhylo()
mtext(text = "millions of years ago", side = 1, line=2.5,at = (max(diag(vcv(excludetree)))/2) )

x<-plot.bammdata(genus.edata, spex="s", breaksmethod="linear", lwd=0.75, tau=0.01, labels=F, colorbreaks = es$colorbreaks)
addBAMMlegend(x, location = c(-1, 1, 20, 130), cex.axis=0.7, labelDist=0.35, tck=-0.005); axisPhylo()
x<-plot.bammdata(genus.edata, spex="e", breaksmethod="linear", lwd=0.75, tau=0.01, labels=F, colorbreaks = ee$colorbreaks)
addBAMMlegend(x, location = c(-1, 1, 20, 130), cex.axis=0.7, labelDist=0.35, tck=-0.005); axisPhylo()
x<-plot.bammdata(genus.edata, spex="netdiv", breaksmethod="linear", lwd=0.75, tau=0.01, labels=F, colorbreaks = ed$colorbreaks)
addBAMMlegend(x, location = c(-1, 1, 20, 130), cex.axis=0.7, labelDist=0.35, tck=-0.005); axisPhylo()
mtext(text = "millions of years ago", side = 1, line=2.5,at = (max(diag(vcv(genustree)))/2) )

x<-plot.bammdata(all.edata, spex="s", breaksmethod="linear", lwd=0.75, tau=0.01, labels=F, colorbreaks = es$colorbreaks)
addBAMMlegend(x, location = c(-1, 1, 20, 180), cex.axis=0.7, labelDist=0.35, tck=-0.005); axisPhylo()
x<-plot.bammdata(all.edata, spex="e", breaksmethod="linear", lwd=0.75, tau=0.01, labels=F, colorbreaks = ee$colorbreaks)
addBAMMlegend(x, location = c(-1, 1, 20, 180), cex.axis=0.7, labelDist=0.35, tck=-0.005); axisPhylo()
x<-plot.bammdata(all.edata, spex="netdiv", breaksmethod="linear", lwd=0.75, tau=0.01, labels=F)
addBAMMlegend(x, location = c(-1, 1, 20, 180), cex.axis=0.7, labelDist=0.35, tck=-0.005); axisPhylo()
mtext(text = "millions of years ago", side = 1, line=2.5,at = (max(diag(vcv(alltree)))/2), cex=1 )

dev.off()
