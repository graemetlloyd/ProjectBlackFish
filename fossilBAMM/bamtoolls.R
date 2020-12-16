library(BAMMtools)
library(coda)
rm(list = ls())
setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/fossilBAMM/")
list.files()

## safe tree ##
setwd("Safe/")
safetree <- read.tree("safe_crowngroup_noanc.tre")
safe.edata <- getEventData(safetree, eventdata = "safe_event_data.txt", burnin = 0.1)
safe.mcmcout <- read.csv("safe_mcmc_out.txt", header = TRUE)
plot(safe.mcmcout$logLik ~ safe.mcmcout$generation, type = "l")

burnstart <- floor(0.05 * nrow(safe.mcmcout))
safe.postburn <- safe.mcmcout[burnstart:nrow(safe.mcmcout), ]
plot(safe.postburn$logLik ~ safe.postburn$generation, type = "l")

## check effective sample sizes ## 
effectiveSize(safe.postburn$N_shifts)
effectiveSize(safe.postburn$logLik)

## table of posterior probabilities for shifts ##
## store all in a table
shift_prob_table <- matrix(data = NA, ncol = 3, nrow = 12)
shift_probs <- summary(safe.edata)
shift_prob_table[shift_probs[,1]+1,1] <- shift_probs[,2]
safe.css <- credibleShiftSet(safe.edata, expectedNumberOfShifts = 1, threshold = 5, set.limit = 0.95)

safe.css$number.distinct ## 247 distinct configurations
summary(safe.css) ## .

pdf(file = "~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/SafeCredibleSetSpec.pdf", height = 7, width = 7)
plot.credibleshiftset(safe.css, spex = "s")
dev.off()
pdf(file = "~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/SafeCredibleSetExt.pdf", height = 7, width = 7)
plot.credibleshiftset(safe.css, spex = "e")
dev.off()
pdf(file = "~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/SafeCredibleSetNetDiv.pdf", height = 7, width = 7)
plot.credibleshiftset(safe.css, spex = "netdiv")
dev.off()
## include shifts in Ziphiidae, delphinidae, and rorquals

safe.bfmat <- computeBayesFactors(safe.postburn, expectedNumberOfShifts = 1, burnin = 0)
pdf(file = "~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/Safe_best_config.pdf", height = 4, width = 7)
par(mfrow = c(1, 3), mar = c(4, 4, 1, 1))
bp <- getBestShiftConfiguration(safe.edata, expectedNumberOfShift = 1, threshold = 5)
safe.phylorates <- plot.bammdata(bp, lwd = 1, legend = TRUE, spex = "s")
#addBAMMshifts(bp, cex=2)
safe.phylorates <- plot.bammdata(bp, lwd = 1, legend = TRUE, spex = "e")
#addBAMMshifts(bp, cex=2)
safe.phylorates <- plot.bammdata(bp, lwd = 1, legend = TRUE, spex = "netdiv")
#addBAMMshifts(bp, cex=2)
dev.off()

## risky tree ##
setwd("..")
riskytree <- read.tree("Risky/risky_crowngroup_noanc.tre")
risky.edata <- getEventData(riskytree, eventdata = "Risky/risky_event_data.txt", burnin = 0.1)
risky.mcmcout <- read.csv("Risky/risky_mcmc_out.txt", header = TRUE)
plot(risky.mcmcout$logLik ~ risky.mcmcout$generation, type = "l")

burnstart <- floor(0.05 * nrow(risky.mcmcout))
risky.postburn <- risky.mcmcout[burnstart:nrow(risky.mcmcout), ]
plot(risky.postburn$logLik ~ risky.postburn$generation, type = "l")

## check effective sample sizes ## 
effectiveSize(risky.postburn$N_shifts)
effectiveSize(risky.postburn$logLik)

## table of posterior probabilities for shifts ##
shift_probs <- summary(risky.edata) # 1 shift = 0.51, 2 shofts = 0.36
shift_prob_table[shift_probs[,1]+1,2] <- shift_probs[,2]

risky.css <- credibleShiftSet(risky.edata, expectedNumberOfShifts = 1, threshold = 5, set.limit = 0.95)
risky.css$number.distinct ## 43 distinct configurations
summary(risky.css)
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/RiskyCredibleSetSpec.pdf", height = 7, width = 7)
plot.credibleshiftset(risky.css, spex = "s")
dev.off()
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/RiskyCredibleSetExt.pdf", height = 7, width = 7)
plot.credibleshiftset(risky.css, spex = "e")
dev.off()
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/RiskyCredibleSetNetDiv.pdf", height = 7, width = 7)
plot.credibleshiftset(risky.css, spex = "netdiv")
dev.off()
## top nine configurations (cumulative 87% of prob) 
## include shifts in Ziphiidae, delphinidae, and rorquals

risky.bfmat <- computeBayesFactors(risky.postburn, expectedNumberOfShifts = 1, burnin = 0)
bp <- getBestShiftConfiguration(risky.edata, expectedNumberOfShift = 1, threshold = 5)
pdf(file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/Risky_best_config.pdf", height = 4, width = 7)
par(mfrow = c(1, 3), mar = c(4, 4, 1, 1))
plot.bammdata(bp, lwd = 1, legend = TRUE, spex = "s")
plot.bammdata(bp, lwd = 1, legend = TRUE, spex = "e")
plot.bammdata(bp, lwd = 1, legend = TRUE, spex = "netdiv")
dev.off()

marg_probs <- marginalShiftProbsTree(risky.edata)
plot.phylo(marg_probs, show.tip.label = F, no.margin = T)
edgelabels(text=round(marg_probs$edge.length, 2))
## dangerous tree ##
dangeroustree <- read.tree("Dangerous/Dangerous_crowngroup_noanc.tre")
dangerous.edata <- getEventData(dangeroustree, eventdata = "Dangerous/Dangerous_event_data.txt", burnin = 0.1)
dangerous.mcmcout <- read.csv("Dangerous/Dangerous_mcmc_out.txt", header = TRUE)
plot(dangerous.mcmcout$logLik ~ dangerous.mcmcout$generation, type = "l")

burnstart <- floor(0.05 * nrow(dangerous.mcmcout))
dangerous.postburn <- dangerous.mcmcout[burnstart:nrow(dangerous.mcmcout), ]
plot(dangerous.postburn$logLik ~ dangerous.postburn$generation, type = "l")

## check effective sample sizes ## 
effectiveSize(dangerous.postburn$N_shifts)
effectiveSize(dangerous.postburn$logLik)

## table of posterior probabilities for shifts ##
shift_probs <- summary(dangerous.edata)
shift_prob_table[shift_probs[,1]+1,3] <- shift_probs[,2]
rownames(shift_prob_table) <- seq(0, 11)
colnames(shift_prob_table) <- c("Safe", "Risky", "Dangerous")
write.csv(shift_prob_table, file="~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/ShiftProbTable.csv" )

#0 shifts best supported (pp = 0.4600), with 1 shifts well supported (pp = 0.23)
dangerous.css <- credibleShiftSet(dangerous.edata, expectedNumberOfShifts=1, threshold=5, set.limit = 0.95)
dangerous.css$number.distinct ## 129 distinct configurations
summary(dangerous.css)

pdf(file = "~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/DangerousCredibleSetSpec.pdf", height = 7, width = 7)
plot.credibleshiftset(dangerous.css, spex = "s")
dev.off()
pdf(file = "~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/DangerousCredibleSetExt.pdf", height = 7, width = 7)
plot.credibleshiftset(dangerous.css, spex = "e")
dev.off()
pdf(file = "~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/Supplementary_Figs/DangerousCredibleSetNetDiv.pdf", height = 7, width = 7)
plot.credibleshiftset(dangerous.css, spex = "netdiv")
dev.off()


bp <- getBestShiftConfiguration(dangerous.edata, expectedNumberOfShift = 1, threshold = 5)


marg_probs <- marginalShiftProbsTree(dangerous.edata)
plot.phylo(marg_probs, show.tip.label = F, no.margin = T)
edgelabels(text=round(marg_probs$edge.length, 2))


## plot all results ##
pdf(file = "~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/ratesthrutime.pdf", width = 7, height = 7)
par(mfcol = c(3, 3), xpd = FALSE)
plotRateThroughTime(safe.edata, intervals = seq(from = 0.05, 0.95, by = 0.01), ratetype = "auto", smooth = TRUE, avgCol = "black", intervalCol = "darkgray",opacity = 0.1, ylim = c(0.1, 0.4), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd = NA); text(51, 0.45, labels = "A.", font = 1, cex = 1.5); par(xpd = FALSE)
plotRateThroughTime(safe.edata, intervals = seq(from = 0.05, 0.95, by = 0.01), ratetype = "extinction", smooth = TRUE, avgCol = "black", intervalCol = "darkgray",opacity = 0.1, ylim = c(0.1, 0.4), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd = NA); text(51, 0.45, labels = "B.", font = 1, cex = 1.5); par(xpd = FALSE)
plotRateThroughTime(safe.edata, intervals = seq(from = 0.05, 0.95, by = 0.01), ratetype = "netdiv", smooth = TRUE, avgCol = "black", intervalCol = "darkgray", opacity = 0.1,ylim = c(-0.1, 0.12), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd = NA); text(51, 0.15, labels = "C.", font = 1, cex = 1.5); par(xpd = FALSE)

plotRateThroughTime(risky.edata, intervals = seq(from = 0.05, 0.95, by = 0.01), ratetype = "auto", smooth = TRUE, avgCol = "black", intervalCol = "darkgray",opacity = 0.1, ylim = c(0.1, 0.4), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd = NA); text(51, 0.45, labels = "D.", font = 1, cex = 1.5); par(xpd = FALSE)
plotRateThroughTime(risky.edata, intervals = seq(from = 0.05, 0.95, by = 0.01), ratetype = "extinction", smooth = TRUE, avgCol = "black", intervalCol = "darkgray",opacity = 0.1, ylim = c(0.1, 0.4), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd = NA); text(51, 0.45, labels = "E.", font = 1, cex = 1.5); par(xpd = FALSE)
plotRateThroughTime(risky.edata, intervals = seq(from = 0.05, 0.95, by = 0.01), ratetype = "netdiv", smooth = TRUE, avgCol = "black", intervalCol = "darkgray",opacity = 0.1, ylim = c(-0.1, 0.12), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd = NA); text(51, 0.15, labels = "F.", font = 1, cex = 1.5); par(xpd = FALSE)

plotRateThroughTime(dangerous.edata, intervals = seq(from = 0.05, 0.95, by = 0.01), ratetype = "auto", smooth = TRUE, avgCol = "black", intervalCol = "darkgray",opacity = 0.1, ylim = c(0.1, 0.4), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd = NA); text(51, 0.45, labels = "G.", font = 1, cex = 1.5); par(xpd = FALSE)
plotRateThroughTime(dangerous.edata, intervals = seq(from = 0.05, 0.95, by = 0.01), ratetype = "extinction", smooth = TRUE, avgCol = "black", intervalCol = "darkgray",opacity = 0.1, ylim=c(0.1,0.4), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd = NA); text(51, 0.45, labels = "H.", font = 1, cex = 1.5); par(xpd = FALSE)
plotRateThroughTime(dangerous.edata, intervals = seq(from = 0.05, 0.95, by = 0.01), ratetype = "netdiv", smooth = TRUE, avgCol = "black", intervalCol = "darkgray", opacity = 0.1,ylim = c(-0.1, 0.12), cex.lab = 0.7, mar = c(6, 5, 2, 1))
par(xpd = NA); text(51, 0.15, labels = "I.", font = 1, cex = 1.5); par(xpd = FALSE)
dev.off()




## plot combined results ##
pdf(file = "~/Dropbox/Mammal_Supertree/cetacean_paper_figures_scripts/meanrates.pdf", width = 7, height = 7)

par(mfcol = c(3, 3), xpd = FALSE)
es <- plot.bammdata(safe.edata, spex = "s", breaksmethod = "linear", lwd = 0.75, tau = 0.01, labels = FALSE, mar = c(4, 3, 1, 1))
addBAMMlegend(es, location = c(-1, 1, 20, 120), cex.axis = 0.7, labelDist = 0.35, tck = -0.005); axisPhylo()
ee <- plot.bammdata(safe.edata, spex = "e", breaksmethod = "linear", lwd = 0.75, tau = 0.01, labels = FALSE)
addBAMMlegend(ee, location = c(-1, 1, 20, 120), cex.axis = 0.7, labelDist = 0.35, tck = -0.005); axisPhylo()
ed <- plot.bammdata(safe.edata, spex = "netdiv", breaksmethod = "linear", lwd = 0.75, tau = 0.01, labels = FALSE)
addBAMMlegend(ed, location = c(-1, 1, 20, 120), cex.axis = 0.7, labelDist = 0.35, tck = -0.005); axisPhylo()
mtext(text = "millions of years ago", side = 1, line = 2.5, at = (max(diag(vcv(safetree))) / 2) )

x <- plot.bammdata(risky.edata, spex = "s", breaksmethod = "linear", lwd = 0.75, tau = 0.01, labels = FALSE, colorbreaks = es$colorbreaks)
addBAMMlegend(x, location = c(-1, 1, 20, 130), cex.axis = 0.7, labelDist = 0.35, tck = -0.005); axisPhylo()
x <- plot.bammdata(risky.edata, spex = "e", breaksmethod = "linear", lwd = 0.75, tau = 0.01, labels = FALSE, colorbreaks = ee$colorbreaks)
addBAMMlegend(x, location = c(-1, 1, 20, 130), cex.axis = 0.7, labelDist = 0.35, tck = -0.005); axisPhylo()
x <- plot.bammdata(risky.edata, spex = "netdiv", breaksmethod = "linear", lwd = 0.75, tau = 0.01, labels = FALSE, colorbreaks = ed$colorbreaks)
addBAMMlegend(x, location = c(-1, 1, 20, 130), cex.axis = 0.7, labelDist = 0.35, tck = -0.005); axisPhylo()
mtext(text = "millions of years ago", side = 1, line = 2.5, at = (max(diag(vcv(riskytree))) / 2) )

x <- plot.bammdata(dangerous.edata, spex = "s", breaksmethod = "linear", lwd = 0.75, tau = 0.01, labels = FALSE, colorbreaks = es$colorbreaks)
addBAMMlegend(x, location = c(-1, 1, 20, 180), cex.axis = 0.7, labelDist = 0.35, tck = -0.005); axisPhylo()
x<-plot.bammdata(dangerous.edata, spex = "e", breaksmethod = "linear", lwd = 0.75, tau = 0.01, labels = FALSE, colorbreaks = ee$colorbreaks)
addBAMMlegend(x, location = c(-1, 1, 20, 180), cex.axis = 0.7, labelDist = 0.35, tck = -0.005); axisPhylo()
x <- plot.bammdata(dangerous.edata, spex = "netdiv", breaksmethod = "linear", lwd = 0.75, tau = 0.01, labels = FALSE, colorbreaks = ed$colorbreaks)
addBAMMlegend(x, location = c(-1, 1, 20, 180), cex.axis = 0.7, labelDist = 0.35, tck = -0.005); axisPhylo()
mtext(text = "millions of years ago", side = 1, line = 2.5, at = (max(diag(vcv(dangeroustree))) / 2), cex = 1 )

dev.off()


### tip rates ###

safe.div<-getTipRates(ephy=safe.edata, returnNetDiv = T)
names(safe.div$netdiv.avg)
delphinid.netdiv <- safe.div$netdiv.avg[1:40]
ziphiid.netdiv <- safe.div$netdiv.avg[88:137]
background <- safe.div$netdiv.avg[-c(1:4, 88:137)]
median(delphinid.netdiv)
median(ziphiid.netdiv)
median(background)


safe.se<-getTipRates(ephy=safe.edata, returnNetDiv = F)
delphinid.spec <- safe.se$lambda.avg[1:40]
delphinid.ex <- safe.se$mu.avg[1:40]
ziphiid.spec <- safe.se$lambda.avg[88:137]
ziphiid.ex <- safe.se$mu.avg[88:137]
background.spec <- safe.se$lambda.avg[-c(1:4, 88:137)]
background.ex <- safe.se$mu.avg[-c(1:4, 88:137)]

median(delphinid.spec)
median(delphinid.ex)
median(ziphiid.spec)
median(ziphiid.ex)
median(background.spec)
median(background.ex)
