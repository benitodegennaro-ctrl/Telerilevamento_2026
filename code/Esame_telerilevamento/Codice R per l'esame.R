# Imposta la cartella di lavoro per gestire correttamente l'input e l'output dei file del progetto
setwd("~/Desktop/Progetto_Ucraina")
#Verifica del percorso impostato: conferma la cartella di lavoro corrente
getwd()
# Elenco dei file presenti nella directory per verificare la corretta disponibilità del dataset
list.files()

#caricamento dei pachetti 
library(terra)     # Per gestire le immagini satellitari
library(imageRy)   # Per facilitarmi il lavoro con le bande
library(ggplot2)   # Per fare i grafici
library(patchwork) # Per mettere i grafici uno accanto all'altro
library(viridis)   # Per i colori delle mappe (così si vedono bene)
library(ggridges)  # Per i grafici a cresta (belli e utili)

#caricamento dei dati raster 
Ucraina_2021<-rast("Ucraina_2021_bands.tif") # dati pre-conflitto (2021)
Ucraina_2023<-rast("Ucraina_2023_bands.tif") # Dati fase intermedia (2023)
Ucraina_2026<-rast("Ucraina_2026_bands.tif") # Dati correnti (2026)

# Interrogazione degli oggetti per la verifica delle informazioni spaziali e delle proprietà
Ucraina_2021
Ucraina_2023
Ucraina_2026

#eseguo i plot dei vari file
plot(Ucraina_2021)
plot(Ucraina_2023)
plot(Ucraina_2026)

#Composizione in Colori Naturali (True Color)
im.multiframe(1,3) #divisione dell interfaccia grafica in 1 riga e tre colonne 
im.plotRGB(Ucraina_2021, r=3, g=2, b=1, title="Ucraina 2021 pre-conflitto") #Composizione spettrale nel dominio del visibile
im.plotRGB(Ucraina_2023, r=3, g=2, b=1, title="Ucraina 2023 periodo critico") #Composizione spettrale nel dominio del visibile
im.plotRGB(Ucraina_2026, r=3, g=2, b=1, title="Ucraina 2026 periodo attuale") #Composizione spettrale nel dominio del visibile
dev.off()

im.multiframe(3, 4) 
 
# Anno 2021
plot(Ucraina_2021[[1]], col=magma(100), main="2021 - B2")
plot(Ucraina_2021[[2]], col=magma(100), main="2021 - B3")
plot(Ucraina_2021[[3]], col=magma(100), main="2021 - B4")
plot(Ucraina_2021[[4]], col=magma(100), main="2021 - B8")
 
# Anno 2023
plot(Ucraina_2023[[1]], col=magma(100), main="2023 - B2")
plot(Ucraina_2023[[2]], col=magma(100), main="2023 - B3")
plot(Ucraina_2023[[3]], col=magma(100), main="2023 - B4")
plot(Ucraina_2023[[4]], col=magma(100), main="2023 - B8")
 
# Anno 2026
plot(Ucraina_2026[[1]], col=magma(100), main="2026 - B2")
plot(Ucraina_2026[[2]], col=magma(100), main="2026 - B3")
plot(Ucraina_2026[[3]], col=magma(100), main="2026 - B4")
plot(Ucraina_2026[[4]], col=magma(100), main="2026 - B8")
