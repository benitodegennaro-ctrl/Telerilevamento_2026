# R cod per visalizzare dati multispettrali 
#pachetto che uso
library(terra) #pachetto che usa 
library(imageRy)
library(viridis) 

#lista immagini presente nella libreria (imageRy)
im.list()

#sentinel-2 bands 
#https://gisgeography.com/sentinel-2-bands-combinations/
#? serve per chiedere l'help 
?im.import()
#per ricevere la lista delle immagini 
im.import()

#modificare palet di colori 
cl<-colorRampPalette(c("turquoise3","thistle3","orangered3"))(100)
plot(b2,col=cl)
#minor numero di bande 
cl<-colorRampPalette(c("turquoise3","thistle3","orangered3"))(3)
plot(b2,col=cl)

#usiamo viridis per cambiare i colori 
plot(b2, col=inferno(100))

#esercizio cambiamo il colore della nostra immagine nella scala di grigi 
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
plot(b2, col=inferno(100))
plot(b2,col=cl)

#lezione/03/05
#ricarico i pacehhti
library(terra) #pachetto che usa 
library(imageRy)
library(viridis) 

#carico l'immagine di sentiel 2 
b2<-im.import("sentinel.dolomites.b2.tif")
#importola banda 
b3<-im.import("sentinel.dolomites.b3.tif")
#cambio il colre della banda 3 
plot(b3, col=plasma(100))
#carico la banda 4 
b4<-im.import("sentinel.dolomites.b4.tif")
#carico la banda 8 
b8<-im.import( "sentinel.dolomites.b8.tif")
#esercizio multiferam con tutte e 4 le bande e le leggende in lina 
#colori 
cl<-colorRampPalette(c("turquoise3","thistle3","orangered3"))(100)
cl1<-colorRampPalette(c("blue","blue2","#00008B"))(100)
cl2<-colorRampPalette(c("chartreuse","chartreuse2","chartreuse4"))(100)
cl3<-colorRampPalette(c("brown","brown2","brown4"))(100)

#divido il panello

im.multifam(2,2)

#plotto le immagini 

plot(b2,col=cl1)
plot(b3, col=cl2)
plot(b4, col=cl3)
plot(b8, col=cl)

plot(b2,b3,b4,b8, col=inferno)

sentinel<-c(b2,b3,b4,b8)
plot(sentinel)
plot(sentinel,col=inferno)

plot(sentinel$sentinel.dolomites.b8.tif)

plot(sentinel [[4]])
plot(sentinel [[2]])
