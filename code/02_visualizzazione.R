# R cod per visalizzare dati multispettrali 

library(terra) #pachetto che usa 
library(imageRy)

im.list()

#sentinel-2 bands 
#https://gisgeography.com/sentinel-2-bands-combinations/

im.import()

#modificare palet di colori 
cl<-colorRampPalette(c("turquoise3","thistle3","orangered3"))(100)
plot(b2,col=cl)
#minor numero di bande 
cl<-colorRampPalette(c("turquoise3","thistle3","orangered3"))(3)
plot(b2,col=cl)

#usiamo viridis per cambiare i colori 
plot(b2, col=inferno(100))

#esercizio 
cambiamo il colore della nostra immagine nella scala di grigi 
cl1<-colorRampPalette(c("gray100","gray50","gray1"))(100)
plot(b2,col=cl1)

#per vbedere immagini una accanto all'altra 
par(mfrow=c(1,2))
plot(b2, col=inferno(100))
plot(b2,col=cl1)

#chiudere le finestre 
dev.off()
#e piu semplice 
?im.multiframe
im.multiframe(1,2)
