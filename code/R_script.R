# first R script 

3+2
#ogetti e assegnazione 
michele<- 2+3
michele

tecla<- 4+6
tecla 
#tutte le operazioni 
michele+tecla 
#arrays o vettori 
sonia<-c(10,8,3,1,0)  #funzione e argomenti 

giorgi<-c(3, 10,20, 50, 100) 
plot(giorgi, sonia)
plot(giorgi,sonia, col="blue")
plot(giorgi,sonia, col="blue", pch=19)
plot(giorgi,sonia, col="blue", pch=19, cex=2)
plot(giorgi,sonia, col="blue", pch=19, cex=2, xlab="inquinanti", ylab="numero_di_delfini")
#istalliamo un pachetto 
#Cran
install.packages("Terra")
library(terra)

#GitHUB
install.packages("devtools") #remotes 
library(devtools)
install_github("ducciorocchini/imageRy")
