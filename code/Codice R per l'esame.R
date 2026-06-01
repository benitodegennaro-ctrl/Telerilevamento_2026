# Imposta la cartella di lavoro per gestire correttamente l'input e l'output dei file del progetto
setwd("~/Desktop/Progetto_ucraina.R")
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

