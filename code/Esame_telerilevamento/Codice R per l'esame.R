# Impostazione della cartella di lavoro del progetto
setwd("~/Desktop/Progetto_ucraina")

# Verifica del percorso corrente
getwd()

# Verifica dei file disponibili nella directory
list.files()

library(terra)     # Per la gestione di dati raster. 
library(imageRy)   # Gestione, analisi e visualizzazione multiframe di immagini raster
library(ggplot2)   # Creazione di grafici statici basata sulla Grammatica della Grafica
library(patchwork) # Combinazione e composizione flessibile di più grafici
library(viridis)   # Palette di colori ad alta leggibilità per daltonici
library(ggridges)  # Grafici a cresta (ridgeline) per visualizzare distribuzioni continue

Ucraina_2021<-rast("Ucraina_2021_bands.tif") # dati pre-conflitto (2021)
Ucraina_2026<-rast("Ucraina_2026_bands.tif") # Dati correnti (2026)
Ucraina_2022<-rast("Ucraina_2022_bands.tif") # Dati fase intermedia (2022)

# Verifica dei metadati e delle proprietà spaziali dei dataset (2021, 2022, 2026)
Ucraina_2021
Ucraina_2026
Ucraina_2022

#visualizzazione delle bande spettrali (2021)
plot(Ucraina_2021)

#visualizzazione delle bande spettrali (2022)
plot(Ucraina_2022)

#visualizzazione delle bande spettrali (2026)
plot(Ucraina_2026)

# Configurazione dello schermo su 1 riga e 3 colonne
im.multiframe(1,3)

# Visualizzazione in colori naturali (RGB 3,2,1) per il confronto temporale (2021, 2022,2026)
im.plotRGB(Ucraina_2021, r=3, g=2, b=1, title="Ucraina 2021 pre-conflitto")
im.plotRGB(Ucraina_2022, r=3, g=2, b=1, title="Ucraina 2022 periodo critico")
im.plotRGB(Ucraina_2026, r=3, g=2, b=1, title="Ucraina 2026 periodo attuale")

# Configurazione dello schermo su 3 righe e 4 colonne
im.multiframe(3, 4) 

# Visualizzazione delle singole bande (B2=Blu, B3=Verde, B4=Rosso, B8=NIR) con palette cividis
# Anno 2021
plot(Ucraina_2021[[1]], col=cividis(100), main="2021 - B2") 
plot(Ucraina_2021[[2]], col=cividis(100), main="2021 - B3") 
plot(Ucraina_2021[[3]], col=cividis(100), main="2021 - B4") 
plot(Ucraina_2021[[4]], col=cividis(100), main="2021 - B8") 

# Anno 2022
plot(Ucraina_2022[[1]], col=cividis(100), main="2022 - B2") 
plot(Ucraina_2022[[2]], col=cividis(100), main="2022 - B3") 
plot(Ucraina_2022[[3]], col=cividis(100), main="2022 - B4") 
plot(Ucraina_2022[[4]], col=cividis(100), main="2022 - B8") 

# Anno 2026
plot(Ucraina_2026[[1]], col=cividis(100), main="2026 - B2") 
plot(Ucraina_2026[[2]], col=cividis(100), main="2026 - B3") 
plot(Ucraina_2026[[3]], col=cividis(100), main="2026 - B4") 
plot(Ucraina_2026[[4]], col=cividis(100), main="2026 - B8")

# Calcolo del Difference Vegetation Index (DVI) utilizzando la banda 4 (NIR) e la banda 3 (Rosso)
dvi_2021 <- im.dvi(Ucraina_2021, 4, 3)
dvi_2022 <- im.dvi(Ucraina_2022, 4, 3)
dvi_2026 <- im.dvi(Ucraina_2026, 4, 3)

# Configurazione dello schermo su 1 riga e 3 colonne
im.multiframe(1, 3) 

# Visualizzazione dell'indice DVI con palette inferno per il confronto temporale
plot(dvi_2021, col=inferno(100), main="DVI 2021") 
plot(dvi_2022, col=inferno(100), main="DVI 2022") 
plot(dvi_2026, col=inferno(100), main="DVI 2026")

# Calcolo del Normalized Difference Vegetation Index (NDVI) tramite bande 4 (NIR) e 3 (Rosso)
ndvi_2021 <- im.ndvi(Ucraina_2021, 4, 3)
ndvi_2022 <- im.ndvi(Ucraina_2022, 4, 3)
ndvi_2026 <- im.ndvi(Ucraina_2026, 4, 3)

# Configurazione dello schermo su 1 riga e 3 colonne
im.multiframe(1, 3) 

# Visualizzazione dell'indice NDVI con palette mako per il confronto temporale
plot(ndvi_2021, col=plasma(100), main="NDVI 2021") 
plot(ndvi_2022, col=plasma(100), main="NDVI 2022") 
plot(ndvi_2026, col=plasma(100), main="NDVI 2026")

# Creazione dello stack dei layer NDVI e assegnazione dei relativi nomi
ndvi_stack <- c(ndvi_2021, ndvi_2022, ndvi_2026)
names(ndvi_stack) <- c("NDVI_2021", "NDVI_2022", "NDVI_2026")

# Generazione del ridgeline plot per il confronto delle distribuzioni con palette inferno
im.ridgeline(ndvi_stack, scale=1, palette="plasma")

# Calcolo delle differenze temporali dell'NDVI tra i diversi periodi
dif_22_21 <- ndvi_2022 - ndvi_2021 
dif_26_22 <- ndvi_2026 - ndvi_2022 
dif_26_21 <- ndvi_2026 - ndvi_2021

# Configurazione dello schermo su 1 riga e 3 colonne
im.multiframe(1, 3)

# Visualizzazione delle variazioni di NDVI con palette inferno
plot(dif_22_21, col=inferno(100), main="dif_NDVI_2022-2021") 
plot(dif_26_22, col=inferno(100), main="dif_NDVI_2026-2022") 
plot(dif_26_21, col=inferno(100), main="dif_NDVI_2026-2021")

# Classificazione non supervisionata in 3 cluster (es. vegetazione e suolo nudo)
class_2021 <- im.classify(ndvi_2021, seed=42, num_clusters=3)
class_2022 <- im.classify(ndvi_2022, seed=42, num_clusters=3)
class_2026 <- im.classify(ndvi_2026, seed=42, num_clusters=3)

# Definizione della legenda a tre classi
levels(class_2021) <- data.frame(value = c(1, 2, 3), label = c("vegetazione", "suolo nudo", "vegetazione rada"))
levels(class_2022) <- data.frame(value = c(1, 2, 3), label = c("vegetazione", "suolo nudo", "vegetazione rada"))
levels(class_2026) <- data.frame(value = c(1, 2, 3), label = c("vegetazione", "suolo nudo","vegetazione rada"))

#personalizzazione della palette di colori 
col_classes <- c("vegetazione" = "chartreuse4","suolo nudo" = "lightsalmon4", "vegetazione rada" ="khaki1")

# Configurazione dello schermo su 1 riga e 3 colonne
im.multiframe(1, 3)

# Disegno delle tre mappe SENZA la legenda automatica lateralmente
plot(class_2021, col=col_classes, main="2021", legend=FALSE)
plot(class_2022, col=col_classes, main="2022", legend=FALSE)
plot(class_2026, col=col_classes, main="2026", legend=FALSE)

# Aggiunta manuale della legenda in basso a sinistra
legend("bottomleft", 
       legend = names(col_classes), 
       fill = col_classes, 
       bg = "white",
       xpd = TRUE)

# Calcolo della frequenza assoluta dei pixel per ciascuna classe
f2021 <- freq(class_2021) 
f2022 <- freq(class_2022) 
f2026 <- freq(class_2026)

# Calcolo della proporzione (frequenza relativa) rispetto al numero totale di celle
prop2021 <- f2021$count / ncell(class_2021) 
prop2022 <- f2022$count / ncell(class_2022) 
prop2026 <- f2026$count / ncell(class_2026) 

# Conversione delle proporzioni in valori percentuali
perc2021 <- prop2021 * 100 
perc2022 <- prop2022 * 100 
perc2026 <- prop2026 * 100

# Creazione del dataframe riassuntivo con le percentuali di suolo nudo e vegetazione per ogni anno
tabella <- data.frame(
  class = c("vegetazione", "suolo nudo","vegetazione rada"),
  percentuale2021 = perc2021,
  percentuale2022 = perc2022,
  percentuale2026 = perc2026
)


# Visualizzazione della tabella finale
tabella

# Generazione dei grafici a barre per il confronto della copertura percentuale negli anni (2021, 2022, 2026)
p1 <- ggplot(tabella, aes(x = class, y = percentuale2021, fill = class)) + 
  geom_bar(stat = "identity") + 
  ylim(c(0,100)) + 
  labs(title="Copertura 2021", x="Classe", y="Percentuale (%)") +
  scale_fill_manual(values = col_classes) +
  theme(legend.position="none")

p2 <- ggplot(tabella, aes(x = class, y = percentuale2022, fill = class)) + 
  geom_bar(stat = "identity") + 
  ylim(c(0,100)) + 
  labs(title="Copertura 2022", x="Classe", y="Percentuale (%)") +
  scale_fill_manual(values = col_classes) +
  theme(legend.position="none")

p3 <- ggplot(tabella, aes(x = class, y = percentuale2026, fill = class)) + 
  geom_bar(stat = "identity") + 
  ylim(c(0,100)) + 
  labs(title="Copertura 2026", x="Classe", y="Percentuale (%)") +
  scale_fill_manual(values = col_classes) +
  theme(legend.position="none")

# Visualizzazione a schermo dei grafici affiancati
p1 + p2 + p3
