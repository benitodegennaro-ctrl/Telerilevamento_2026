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
Ucraina_2021<-rast("Sentinel2_Izyum_2021.tif") # dati pre-conflitto (2021)
Ucraina_2022<-rast("Sentinel2_Izyum_2022.tif") # Dati fase intermedia (2023)
Ucraina_2026<-rast("Sentinel2_Izyum_2026.tif") # Dati correnti (2026)

# Interrogazione degli oggetti per la verifica delle informazioni spaziali e delle proprietà
Ucraina_2021
Ucraina_2022
Ucraina_2026

#eseguo i plot dei vari file
plot(Ucraina_2021)
plot(Ucraina_2022)
plot(Ucraina_2026)

#Composizione in Colori Naturali (True Color)
im.multiframe(1,3) #divisione dell interfaccia grafica in 1 riga e tre colonne 
im.plotRGB(Ucraina_2021, r=3, g=2, b=1, title="Ucraina 2021 pre-conflitto") #Composizione spettrale nel dominio del visibile
im.plotRGB(Ucraina_2022, r=3, g=2, b=1, title="Ucraina 2022 periodo critico") #Composizione spettrale nel dominio del visibile
im.plotRGB(Ucraina_2026, r=3, g=2, b=1, title="Ucraina 2026 periodo attuale") #Composizione spettrale nel dominio del visibile
dev.off()

# Analisi della scomposizione spettrale multitemporale
im.multiframe(3, 4) #suddivisione interfaccia grafica 
 
# Anno 2021
plot(Ucraina_2021[[1]], col=magma(100), main="2021 - B2") # Riflettanza nel visibile (blu)
plot(Ucraina_2021[[2]], col=magma(100), main="2021 - B3") # Riflettanza nel visibile (verde)
plot(Ucraina_2021[[3]], col=magma(100), main="2021 - B4") # Riflettanza nel visibile (rosso)
plot(Ucraina_2021[[4]], col=magma(100), main="2021 - B8") # Riflettanza nel vicino infrarosso (biomassa)
 
# Anno 2022
plot(Ucraina_2022[[1]], col=magma(100), main="2022 - B2") # Riflettanza nel visibile (blu)
plot(Ucraina_2022[[2]], col=magma(100), main="2022 - B3") # Riflettanza nel visibile (verde)
plot(Ucraina_2022[[3]], col=magma(100), main="2022 - B4") # Riflettanza nel visibile (rosso)
plot(Ucraina_2022[[4]], col=magma(100), main="2022 - B8") # Riflettanza nel vicino infrarosso (biomassa)
 
# Anno 2026
plot(Ucraina_2026[[1]], col=magma(100), main="2026 - B2") # Riflettanza nel visibile (blu)
plot(Ucraina_2026[[2]], col=magma(100), main="2026 - B3") # Riflettanza nel visibile (verde)
plot(Ucraina_2026[[3]], col=magma(100), main="2026 - B4") # Riflettanza nel visibile (rosso)
plot(Ucraina_2026[[4]], col=magma(100), main="2026 - B8") # Riflettanza nel vicino infrarosso (biomassa)

#clacolo del DVI tramite im.dvi del pachetto ImageRy 
dvi_2021<- im.dvi(Ucraina_2021, 4,3) #calcolo dell differnt vegetation index anno 2021 
dvi_2022<- im.dvi(Ucraina_2022, 4,3) #calcolo dell differnt vegetation index anno 2023
dvi_2026<- im.dvi(Ucraina_2026, 4,3) #calcolo dell differnt vegetation index anno 2026

#Visualizzazione su mappa dell DVI 
im.multiframe(1,3) #suddivisione dell'interfaccia grafica in una riga e tre colonne 
#Utilizzo della palette 'inferno' per garantire una rappresentazione percettivamente uniforme e accessibile dei dati continui di DVI
plot(dvi_2021, col=inferno(100), main="DVI 2021") #visione dell' indice dvi per l'anno 2021 
plot(dvi_2022, col=inferno(100), main="DVI 2022") #visione dell' indice dvi per l'anno 2023
plot(dvi_2026, col=inferno(100), main="DVI 2026") #visione dell' indice dvi per l'anno 2026 

#caclo del NDVI
ndvi_2021<-im.ndvi(Ucraina_2021,4,3) #NDVI anno 2021
ndvi_2022<-im.ndvi(Ucraina_2022,4,3) #NDVI anno 2023
ndvi_2026<-im.ndvi(Ucraina_2026,4,3) #NDVI anno 2026

im.multiframe(1,3) #suddivisione dell'interfaccia grafica in  1 riga e 3 colonne
#visualizzazione dei vari NDVI 
plot(ndvi_2021, col=mako(100), main="NDVI 2021") # visualizzazione NDVI 2021
plot(ndvi_2022, col=mako(100), main="NDVI 2022") # visualizzazione NDVI 2022
plot(ndvi_2026, col=mako(100), main="NDVI 2026") # visualizzazione NDVI 2026

# Calcolo delle differenze (Change Detection)
dif_22_21 <- ndvi_2022 - ndvi_2021
dif_26_22 <- ndvi_2026 - ndvi_2022
dif_26_21 <- ndvi_2026 - ndvi_2021

#suddivisione dell'interfaccia grafica in una riga e tre colonne 
im.multiframe(1,3)
plot(dif_22_21, col=inferno(100), main="dif_NDVI_2023-2021") #visalizzazione della differenza tra l'anno 2023 e 2021
plot(dif_26_22, col=inferno(100), main="dif_NDVI_2026-2023") #visualizzazione della differenza tra l'anno 2026 e 2023
plot(dif_26_21, col=inferno(100), main="dif_NDVI_2026-2021") #visualizzazione della differenza tra l'anno 2023 e 2021

# classificazione della vegetazione 
# Classificazione in 3 cluster (es. 1 = Vegetazione, 2 = suolo nudo )
class_2021 <- im.classify(ndvi_2021, num_clusters=2 ) #Classificazione dell'NDVI del 2021 
class_2022 <- im.classify(ndvi_2022, num_clusters=2 ) #Classificazione dell'NDVI del 2022
class_2026 <- im.classify(ndvi_2026, num_clusters=2 ) #Classificazione dell'NDVI del 2026

# Definizione della legenda a due classi
levels(class_2021) <- data.frame( value = c(2, 1), label = c("vegetazione", "suolo nudo"))
levels(class_2022) <- data.frame( value = c(2, 1), label = c("vegetazione", "suolo nudo"))
levels(class_2026) <- data.frame( value = c(2, 1), label = c("vegetazione", "suolo nudo"))

#visualizzazione della classificazione 
im.multiframe(1,3) #divisione dell'interfaccia grafica in un riga tre colonne 
plot(class_2021, main="2021") #visualizzazione classi 2021
plot(class_2022, main="2022") #visualizzazione classi 2023
plot(class_2026, main="2026") #visualizzazione classi 2026


# Estrazione delle frequenze con etichette incluse
f2021 <- freq(class_2021)
f2023 <- freq(class_2022)
f2026 <- freq(class_2026)

#calcolo fgrequenza relativa 
prop2021 <- f2021$count / ncell(class_2021)
prop2022 <- f2023$count / ncell(class_2022)
prop2026 <- f2026$count / ncell(class_2026)

#conversione in dati percentuali 
perc2021 <- prop2021 * 100
perc2022 <- prop2022 * 100
perc2026 <- prop2026 * 100

#crazione di una tabella con i dati calcolati 
tabella <- data.frame(
  class = c("suolo nudo", "vegetazione"),
  perc2021 = percentuale2021,
  perc2022 = percentuale2022,
  perc2026 = percentuale2026)

# Visualizzazione della tabella finale
tabella
