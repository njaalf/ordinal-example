## public dataset dec 22
## njål foldnes and steffen grønneberg
## illustration 3 in article http://dx.doi.org/10.1037/met0000495
library(lavaan)

Xstar <- read.table("Xstar.csv", header=TRUE)

ftwofactor <- cfa("F1=~ X1star+X2star+X3star; F2=~ X4star+X5star+X6star", data=Xstar,
                  estimator="MLM", std.lv=T)
#Correctly specified:
fitmeasures(ftwofactor, c("pvalue.scaled", "rmsea.robust"))
#pvalue.scaled  rmsea.robust 
#       0.219         0.004 


fonefactor <- cfa("F1=~ X1star+X2star+X3star+ X4star+X5star+X6star", data=Xstar,
                  estimator="MLM", std.lv=T)
# Severely misspecified, e.g.
fitmeasures(fonefactor, c("pvalue.scaled", "rmsea.robust"))
#pvalue.scaled  rmsea.robust 
#0.00          0.24 

#difftest confirms that onefactor is untenable for continuous data
anova(fonefactor, ftwofactor)# < 2.2e-16 ***

### DISCRETIZE K=7, arbitrarily chosen to attain symmetrical barplots
probs <- c(.05, .1, .2, .3, .2, .1, .05 )
thr <- quantile(X1star, probs=cumsum(probs))[-length(probs)] # chosen so that ordinal data looks nice and "normal"

X123 <- apply(XstarSample[, 1:3], 2,  FUN=cut, breaks=c(-Inf, thr, Inf), labels=F)
barplot(table(X123[, 1]))
X456 <- apply(XstarSample[, 4:6], 2,  FUN=cut, breaks=c(-Inf, -rev(thr), Inf), labels=F)
barplot(table(X456[, 2]))

X <- data.frame(cbind(X123, X456)); colnames(X) <- paste0("X", 1:6)

ftwofactor_cat <- cfa("F1=~ X1+X2+X3; F2=~ X4+X5+X6", data=X,
                 ordered=colnames(X), std.lv=T)
#Correctly specified, but the two factors are (almost) perfectly correlated
subset(parameterestimates(ftwofactor_cat), lhs=="F1" & rhs=="F2")[, 1:4]#0.996
fitmeasures(ftwofactor_cat, c("pvalue.scaled", "rmsea.scaled"))
#pvalue.scaled  rmsea.scaled 
#0.56          0.00

#one factor model 
fonefactor_cat <- cfa("F1=~ X1+X2+X3+X4+X5+X6", data=X,
                      ordered=colnames(X), std.lv=T)
#Correctly specified
fitmeasures(fonefactor_cat, c("pvalue.scaled", "rmsea.scaled"))
#pvalue.scaled  rmsea.scaled 
#0.455         0.000 

## DIFFTESTING CONFIRMS THAT ONE-FACTOR MODEL IS RETAINED
anova(fonefactor_cat, ftwofactor_cat)
# pval 0.1601


### Treat ordinal as continuous, 
##as is often recommended for K=7 and symmetrical data?

ftwofactor_cont <- cfa("F1=~ X1+X2+X3; F2=~ X4+X5+X6", data=X,
                      estimator="MLM", std.lv=T)
#Correctly specified, but the two factors are (almost) perfectly correlated
subset(parameterestimates(ftwofactor_cont), lhs=="F1" & rhs=="F2")[, 1:4]#0.996
fitmeasures(ftwofactor_cont, c("pvalue.scaled", "rmsea.scaled"))
#pvalue.scaled  rmsea.scaled 
#0.541         0.000 

#one factor model 
fonefactor_cont <- cfa( "F1=~ X1+X2+X3+X4+X5+X6", data=X,
                      estimator="MLM", std.lv=T)
#Correctly specified
fitmeasures(fonefactor_cont, c("pvalue.scaled", "rmsea.scaled"))
#pvalue.scaled  rmsea.scaled 
#0.422         0.001

## DIFFTESTING CONFIRMS THAT ONE-FACTOR MODEL IS RETAINED ALSO FOR CONT 
## APPROACH
anova(fonefactor_cont, ftwofactor_cont)
# pval 0.1396




