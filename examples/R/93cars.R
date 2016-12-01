# ANALYSIS OF 93CARS DATA (see 93cars_desc.html for motivation)

pdf("93cars_R_out.pdf") # create graphical output file

library(gridExtra)      # needed for 'grid.arrange' function later
library(ggplot2)        # beautiful capabilities offered here!
library(stargazer)      # see citation below

cars0 <- read.table("93cars.txt",na.strings="*",header=T)

cars <- subset(cars0,select = c(manu,model,type,price,ctympg,hwympg,cyl,wght,dmst))
attach(cars)

frgn.cars <- subset(cars,dmst==0,select = c(price,ctympg,hwympg,wght))
dmst.cars <- subset(cars,dmst==1,select = c(price,ctympg,hwympg,wght))

stargazer(frgn.cars, out="ForeignPriceMPGWeight.html",
          title="Foreign Car Price, City MPG, Highway MPG & Weight", median=TRUE, iqr=TRUE) 

stargazer(dmst.cars, out="DomesticPriceMPGWeight.html",
          title="Domestic Car Price, City MPG, Highway MPG & Weight", median=TRUE, iqr=TRUE) 

A <- cbind(subset(frgn.cars,select=ctympg),rep("Foreign City"))
names(A) <- c("mpg","Type")
B <- cbind(subset(dmst.cars,select=ctympg),rep("Domestic City"))
names(B) <- c("mpg","Type")
CTY <- rbind(A,B)

A <- cbind(subset(frgn.cars,select=hwympg),rep("Foreign Highway"))
names(A) <- c("mpg","Type")
B <- cbind(subset(dmst.cars,select=hwympg),rep("Domestic Highway"))
names(B) <- c("mpg","Type")
HWY <- rbind(A,B)

X <- rbind(CTY,HWY)
{
  p <- qplot(factor(Type), mpg, data=X, geom="boxplot") + geom_boxplot(aes(fill = factor(Type))) 
  p + theme(legend.position="none")        # remove the (unnecessary) legend
}   

# http://docs.ggplot2.org/0.9.3.1/geom_boxplot.html


wc <- lm(ctympg~wght)   # linear model (simple linear regression:
                        # City MPG as a function of Weight)
{
  par(mfrow=c(1,1))
  plot(wght, ctympg, xlab="Weight",ylab="City MPG",main="City Miles per Gallon versus Weight", col="magenta4", pch=18)
  abline(wc, lty=1, col = 'red', lwd=3)
}

# model diagnostics for least squares regression, using ggplot2

{
#lm regression line with confidence band
  p1<- qplot(x=wght, y=ctympg, pch="19") + geom_smooth(method="lm", colour="red", size=1) + theme(legend.position="none") 
# fitted values-residual plot
  p2<- ggplot(wc, aes(.fitted, .resid)) + geom_hline(yintercept=0, colour="purple", size=1) + geom_point() + geom_smooth(size=1, se =F)
# fitted values-standardized residual plot
  p3<- p2 + aes(y= .stdresid) + geom_hline(yintercept=0, colour="orange", size=1)
# Cook's distance, with size proportional to distance
  p4<- p2 + aes(size= .cooksd) + scale_size_area("Cook's distance") + geom_hline(yintercept=0, colour="coral2", size=1) + theme(legend.position="none") 
# use "arrange" function to fit plots on same image
  grid.arrange(p1,p2,p3,p4,ncol=2) 
}      

detach(cars)  

dev.off() # close the file 

# Hlavac, Marek (2015). stargazer: Well-Formatted Regression and Summary Statistics Tables.
# R package version 5.2. http://CRAN.R-project.org/package=stargazer 
