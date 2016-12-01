# ANALYSIS OF FURNACE DATA (see furnace_desc.txt for motivation)

library(methods)
library(grDevices)

pdf("furnace_R_out.pdf") # create graphical output file

furnace0 <- read.delim("furnace.txt",header=TRUE)

furnace <- subset(furnace0,select = c(CHArea,CHHght,Age,BTUIn, BTUOut,Damper))
head(furnace,25)     # just one missing datapoint (CHArea in line 24)

furnace$Damper <- factor(furnace$Damper,levels=1:2)  # reinterpret "Damper" as factor variable
is(furnace$Damper)[1]                                # 'is' identifies variable type

names(furnace)       # names of all variables in dataframe...
str(furnace)         # ...more structural information...
summary(furnace)     # ...and associated summary statistics

attach(furnace)

mean(CHArea,na.rm=TRUE) # NaN arises if option is undeclared

sd(CHArea,na.rm=TRUE)   # (curiously not given by 'summary'!)


# BTU scatterplot, stratified by damper type

{
plot(BTUOut[Damper==1]~BTUIn[Damper==1],
     xlab="BTUIn",ylab="BTUOut",xaxt="n",yaxt="n",
     main="BTUIn vs BTUOut for Stratified Furnace Data",
     xlim=c(2,20),ylim=c(2,22),col="blue",pch=1)
points(BTUOut[Damper==2]~BTUIn[Damper==2],col="red",pch=4) 
axis(1,at=seq(2,20,2))
axis(2,at=seq(2,22,2))
legend(15,8,c('EVD','TVD'),pch=c(1,4),col=c("blue","red"))
}


# BTUIn histogram & 90% parameter confidence intervals

{
hist(BTUIn, freq=TRUE, border="darkblue",xaxt="n",
     main="BTUIn Histogram & Normal Fit",
     xlim=c(2,20),ylim=c(0,30),plot=TRUE)
axis(1,at=seq(2,20,2))
curve(180*dnorm(x,mean(BTUIn),sd(BTUIn)),
     from=0,to=20,add=TRUE,col="green",lwd=2)
}

count <- function(x) sum(!is.na(x))
N <- count(BTUIn)
M <- mean(BTUIn)
S <- sd(BTUIn)

A <- M+S*qt(0.05,N-1)/sqrt(N)   # qt returns specified %-tiles of
B <- M+S*qt(0.95,N-1)/sqrt(N)   # Student t distribution, N-1 dof
cat('90 pct CI about BTUIn mean:', A, M, B, '\n')

A <- S*sqrt((N-1)/qchisq(0.95,N-1))  # qchisq returns specified
B <- S*sqrt((N-1)/qchisq(0.05,N-1))  # %-tiles of Chi square dist
cat('90 pct CI about BTUIn stdv:', A, S, B, '\n')


# Simple linear regression

lm(BTUOut~BTUIn)  # very brief output!

btu <- lm(BTUOut~BTUIn)   # give the linear model object a name
summary(btu)   # R^2 (square of correlation coefficient)

{
plot(BTUOut~BTUIn,
     xlab="BTUIn",ylab="BTUOut",
     main="BTUIn vs BTUOut and Least Squares Regression Line",
     xlim=c(2,20),ylim=c(2,22),col="plum",pch=5)
abline(btu, col="powderblue", lwd=2)
FIT <- fitted(btu)        # y-values we expect for observed 
                          # x-values,given the linear fit
segments(BTUIn,FIT,BTUIn,BTUOut)   # (x1,y1,x2,y2)
}


# Regression diagnostic plots
{
par(mfrow=c(3,2),mex=0.5) # establish 3x2 layout, compressed margin
plot(btu,which=1:6)       # Cook's distance: measure of influence of
}                         # each obs on the regression coefficients

par(mfrow=c(1,1),mex=1)   # reset
 
dev.off() # close the file 
