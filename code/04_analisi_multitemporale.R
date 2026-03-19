#coad permorare le immagini sarellitari 
library(terra)
library(imageRy)
library(viridis)
im.list()
#immporto i dati 
En_01<-im.import("EN_01")
En_13<-im.import("EN_13")
En_01<-flip(En_01)
En_13<-flip(En_13)
#
im.multiframe(2,1)
plot(En_01)
plot(En_13)

#DXiffernza
en_diff<-En_01[[1]]-En_13[[1]]

#grealnand esempio 

g_05<-im.import("greenland.2005.tif")
g_0<-im.import(  "greenland.2000.tif")
g_15<-im.import("greenland.2015.tif" )
g_10<-im.import( "greenland.2010.tif")

stac<-c(g_0, g_05, g_10, g_15)
g<-im.import("greenland")
im.multiframe(1,2)
plot(g[[1]])
plot(g[[4]])
plot(g[[1]], col=plasma (100))
plot(g[[4]], col=plasma (100))
dif<-g[[4]]-g[[1]]
plot(dif)

im.plotRGB(g, r=1,g=2, b=4)

