mydata <- "risky.edata"
mytree<- "riskytree"

# Plot two processes separately with 90% CI and loess smoothing
par(mfrow=c(1,3))
plotRateThroughTime(risky.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "auto", smooth=TRUE, avgCol = "black", intervalCol = "gray", ylim=c(0.1,0.25))
plotRateThroughTime(risky.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "extinction", smooth=TRUE, avgCol = "black", intervalCol = "gray", ylim=c(0.1,0.25))
plotRateThroughTime(risky.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "netdiv", smooth=TRUE, avgCol = "black", intervalCol = "gray")



mynode<-getmrca(safetree, "Orcinus_orca","Tursiops_aduncus")
par(mfrow=c(1,3))
plotRateThroughTime(risky.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "auto", node = mynode, nodetype="exclude", smooth=TRUE, avgCol = "blue", intervalCol = "lightblue", ylim=c(0.15,0.3))
plotRateThroughTime(risky.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "auto", node = mynode, nodetype="include", smooth=TRUE, avgCol = "orange", intervalCol = "yellow", ylim=c(0.15,0.3), add=T)

plotRateThroughTime(risky.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "extinction",node = mynode, nodetype="exclude", smooth=TRUE, avgCol = "blue", intervalCol = "lightblue", ylim=c(0,0.25))
plotRateThroughTime(risky.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "extinction", node = mynode, nodetype="include", smooth=TRUE, avgCol = "orange", intervalCol = "yellow", ylim=c(0,0.25), add=T)

plotRateThroughTime(risky.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "netdiv",node = mynode, nodetype="exclude", smooth=TRUE, avgCol = "blue", intervalCol = "lightblue", ylim=c(0,0.05))
plotRateThroughTime(risky.edata, intervals=seq(from=0.05,0.95,by=0.01), ratetype = "netdiv", node = mynode, nodetype="include", smooth=TRUE, avgCol = "orange", intervalCol = "yellow", ylim=c(0,0.05), add=T)


risky.edata <- safe.edata
