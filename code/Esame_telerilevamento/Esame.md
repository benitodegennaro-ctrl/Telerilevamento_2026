>> ### Esame di telerilevamento geo-ecologico in R 2026
> > Benito De Gennaro mat. 1218365

# Analisi tramite telerilevamento degli effetti del conflitto armato sull'ambiente in Ucraina 🛰️       
### 🌱 Monitoraggio della salute vegetativa tramite indici spettrali
### 🗓️ Periodo di studio: 2021-2026
---
# 📕 Introduzione 
Il progetto si propone di analizzare gli effetti ambientali del conflitto armato nella regione di **Zaporizhzhia**, area di grande importanza agricola in Ucraina, attraverso l'impiego delle immagini satellitari di Sentinel-2 (programma Copernicus), è stato possibile osservare le dinamiche di trasformazione del territorio nell'arco temporale 2021-2026. L'analisi si è articolata in tre momenti chiave:
- **2021** (Baseline): rappresenta il territorio in condizioni di normalità, prima dell'escalation del conflitto.
- **2022** (Fase critica): evidenzia l'impatto diretto delle attività belliche sulla copertura del suolo e sulla salute della vegetazione.
- **2026** (Situazione attuale): permette di valutare il grado di ripristino dell'ecosistema o, al contrario, la persistenza dei danni ambientali nel tempo.
  
<img src="Immagini/Screenshot 2026-06-05 alle 14.26.48.png" width="600">

# 📌Obiettivi
L'obiettivo è quantificare l'impatto bellico, non solo attraverso un'analisi qualitativa (composizioni RGB), ma anche mediante l'elaborazione quantitativa di indici di vegetazione: Difference Vegetation Index (DVI) e Normalized Difference Vegetation Index (NDVI). L'analisi multitemorale 2021-2026 permette inoltre, di indagare la resilienza dell'ecosistema in un'area soggetta a pressioni antropiche estreme.

# 🛠️Materiali e metodi 
## Acquisizione dati 
Le immagini sono state acquisite dal portale web di [Google Earth Engine](https://earthengine.google.com/), selezionando una delle aree colpite nel conflitto.
## Caratteristiche del sensore (sentinel 2) 
Per l'analisi è stato utilizzato il satellite Sentinel-2 (programma Copernicus), scelto per le sue caratteristiche tecniche:
- **Risoluzione spaziale**: 10 metri nelle bande del visibile e nel NIR, essenziale per il dettaglio agrario.
- **Risoluzione temporale**: Alta frequenza di rivisitazione, ideale per serie storiche multitemporali (2021-2026).
- **Bande spettrali**: Presenza delle bande NIR e SWIR, necessarie per il calcolo preciso degli indici NDVI e NBR.

| Banda | Nome Comune |
| :---: | :--- |
| **B2** | Blu |
| **B3** | Verde |
| **B4** | Rosso |
| **B8** | Vicino Infrarosso (NIR) |
| **B11** | Infrarosso a onde corte (SWIR 1) |


>[!NOTE]
>
> Il codice JavaScript utilizzato per l'acquisizione delle immagini è disponibile nel file code.js.

## Inizio dell'analisi tramite il software R 


````r
# Imposta la cartella di lavoro per gestire correttamente l'input e l'output dei file del progetto
setwd("~/Desktop/Progetto_ucraina.R")
#Verifica del percorso impostato: conferma la cartella di lavoro corrente
getwd()
# Elenco dei file presenti nella directory per verificare la corretta disponibilità del dataset
list.files()
````
Caricamento dei pacchetti che verranno utilizzati nello studio.
````r
library(terra)     # Per la gestione di dati raster. 
library(imageRy)   # Gestione, analisi e visualizzazione multiframe di immagini raster
library(ggplot2)   # Creazione di grafici statici basata sulla Grammatica della Grafica
library(patchwork) # Combinazione e composizione flessibile di più grafici
library(viridis)   # Palette di colori ad alta leggibilità per daltonici
library(ggridges)  # Grafici a cresta (ridgeline) per visualizzare distribuzioni continue
````
## Importazione dei dati 
Carico i dati raster acquisiti da Sentinel-2.
````r
Ucraina_2021<-rast("Ucraina_2021_bands.tif") # dati pre-conflitto (2021)
Ucraina_2022<-rast("Ucraina_2022_bands.tif") # Dati fase intermedia (2022)
Ucraina_2026<-rast("Ucraina_2026_bands.tif") # Dati correnti (2026)
````

## Verifica dei metadati dei dati raster caricati 

Prima di procedere con l'elaborazione, interrogo i tre oggetti ````Ucraina_2021````,````Ucraina_2022````e ```` Ucraina_2026````per validare le loro proprietà spaziali e strutturali. Questo passaggio è necessario per confermare che i dati siano correttamente allineati e pronti per l'analisi comparativa. In particolare, verifico:

- **Dimensioni**:Risoluzione spaziale e numero di pixel.
- **Bande**:Numero e tipologia di bande spettrali disponibili.
- **Sistema di riferimento** Fondamentale per garantire la sovrapponibilità geografica dei layer.
- **Estensione** Coordinate dei limiti dell'area di studio.

````r
# Interrogazione degli oggetti per la verifica delle informazioni spaziali e delle proprietà
Ucraina_2021
Ucraina_2022
Ucraina_2026
````
Dall'interrogazione degli oggetti, risulta che tutti e tre i dataset presentano le medesime caratteristiche strutturali, nello specifico:
- la classe : SpatRaster
- la dimensione : 1114, 1671, 6 
- la risoluzione : 8.983153e-05, 8.983153e-05
- l'estensione : 35.79993, 35.95004, 47.39997, 47.50004
- il sistema di riferimento : WGS 84 (EPSG:4326)
- le bande : B2, B3, B4, B8, B11

## Visualizzazione delle immagini 
**2021**
````r
#visualizzazione delle bande spettrali (2021)
plot(Ucraina_2021)
````
<img src="Immagini/plot_2021.png" width="800">

**2022**
````r
#visualizzazione delle bande spettrali (2022)
plot(Ucraina_2022)
````
<img src="Immagini/plot_2022.png" width="800">

**2026**
````r
#visualizzazione delle bande spettrali (2026)
plot(Ucraina_2026)
````
<img src="Immagini/plot_2026.png" width="800">

## Composizione in Colori Naturali (True Color)
````r
#Composizione in Colori Naturali (True Color)
im.multiframe(1,3) #divisione dell' interfaccia grafica in 1 riga e tre colonne 
im.plotRGB(Ucraina_2021, r=3, g=2, b=1, title="Ucraina 2021 pre-conflitto") #Composizione spettrale nel dominio del visibile (2021 pre-conflitto)
im.plotRGB(Ucraina_2022, r=3, g=2, b=1, title="Ucraina 2022 periodo critico") #Composizione spettrale nel dominio del visibile (2022 fase critica)
im.plotRGB(Ucraina_2026, r=3, g=2, b=1, title="Ucraina 2026 periodo attuale") #Composizione spettrale nel dominio del visibile (2026 stato attuale)
````
<img src="Immagini/RGB.png" width="800">

La serie multitemporale analizzata consente di quantificare i processi di degradazione del suolo in funzione dell'escalation del conflitto


## Analisi della scomposizione spettrale multitemporale
Attraverso il confronto tra le bande del visibile (B2, B3, B4) e la banda del vicino infrarosso (B8), è possibile isolare la risposta riflettiva del suolo e della vegetazione in tre differenti fasi temporali: baseline (2021), fase critica (2022) e situazione attuale (2026).

````r
#Suddivisione dell'interfaccia grafica 
im.multiframe(3, 4) 
 
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
````
<img src="Immagini/Scomposizione.png" width="800">

Dall'osservazione delle immagini emerge una netta variazione nella banda del vicino infrarosso (B8), dove la perdita di riflettanza tra il 2021 e il 2026 evidenzia una significativa distruzione della copertura vegetale. 
- Nel **2021** la presenza di pixel gialli nella banda (B8) indica una elevata riflettanza nel vicino infrarosso, caratteristica tipica di una vegetazione sana e vigorosa
- ⁠Nel **2022** i toni chiari iniziano ad attenuarsi, indicando un primo calo della riflettanza
- ⁠nel **2026** l'immagine diventa molto scura questa massiccia perdita di riflettanza nel vicino infrarosso documenta una quasi totale perdita di vegetazione

## 🌾 Calcolo degli indici vegetazionali 

### Different vegetation index (DVI) 
Il DVI index viene utilizzato per valutare la presenza di vegetazione. Il DVI sfrutta la differente risposta spettrale della vegetazione nelle bande del rosso e del vicino infrarosso. Le piante sane assorbono gran parte della radiazione nella banda del rosso per i processi fotosintetici e riflettono intensamente la radiazione nel vicino infrarosso. Di conseguenza, la differenza tra queste due bande consente di stimare la presenza e la vigoria della copertura vegetale.

$` DVI = NIR - RED `$   
````r
#Calcolo del DVI tramite im.dvi del pacchetto ImageRy 
dvi_2021<- im.dvi(Ucraina_2021, 4,3) #calcolo del different vegetation index anno 2021 
dvi_2022<- im.dvi(Ucraina_2022, 4,3) #calcolo del differnet vegetation index anno 2022
dvi_2026<- im.dvi(Ucraina_2026, 4,3) #calcolo del differnet vegetation index anno 2026
````
Tramite la visualizzazione delle carte prodotte, è possibile apprezzare la variazione temporale della biomassa e identificare chiaramente le aree colpite dal degrado ambientale

````R
im.multiframe(1,3) #suddivisione dell'interfaccia grafica in una riga e tre colonne 
#Utilizzo della palette 'inferno' per garantire una rappresentazione percettivamente uniforme e accessibile dei dati continui di DVI
plot(dvi_2021, col=inferno(100), main="DVI 2021") #visione dell' indice dvi per l'anno 2021 
plot(dvi_2022, col=inferno(100), main="DVI 2022") #visione dell' indice dvi per l'anno 2022
plot(dvi_2026, col=inferno(100), main="DVI 2026") #visione dell' indice dvi per l'anno 2026
````
<img src="Immagini/Calcolo_DVI.png" width="800">

Dal confronto del DVI si può osservare un progressivo e drastico calo del vigore vegetativo, rilevando una forte diminuzione di biomassa nel 2022, processo che appare ulteriormente accentuato nel 2026.

### Normalized Difference Vegetation Index (NDVI)
Il *Normalized Difference Vegetation Index*  si utilizza per valutare lo stato di salute e la densità di copertura vegetale. L'indice NDVI analogamente all'indice DVI sfrutta la differente risposta spettrale della vegetazione nelle bande del rosso (Red) e del vicino infrarosso (NIR). Tuttavia grazie alla normalizzazione l'NDVI assume valori compresi tra -1 e +1, facilitando il confronto tra immagini acquisite in periodi differenti. 

$NDVI = \frac{NIR - Red}{NIR + Red}$

- Valori prossimi a +1 indicano vegetazione sana e vigorosa
- Valori vicini allo 0 indicano vegetazione rada
- Valori negativi sono generalmente associati a superfici d'acqua, aree urbanizzate o suoli privi di vegetazione.

````r
#calcolo del NDVI
ndvi_2021<-im.ndvi(Ucraina_2021,4,3) #NDVI anno 2021
ndvi_2022<-im.ndvi(Ucraina_2022,4,3) #NDVI anno 2022
ndvi_2026<-im.ndvi(Ucraina_2026,4,3) #NDVI anno 2026
````
La distribuzione spaziale del vigore fotosintetico calcolato viene visualizzata di seguito.

````r
im.multiframe(1,3) #suddivisione dell'interfaccia grafica in  1 riga e 3 colonne
#visualizzazione dei vari NDVI 
plot(ndvi_2021, col=mako(100), main="NDVI 2021") # visualizzazione NDVI 2021
plot(ndvi_2022, col=mako(100), main="NDVI 2022") # visualizzazione NDVI 2022
plot(ndvi_2026, col=mako(100), main="NDVI 2026") # visualizzazione NDVI 2026
````
Il confronto multitemporale delle mappe di NDVI mostra una progressiva diminuzione dei valori dell'indice a partire dal 2022, indicativa di una significativa riduzione della vigoria vegetativa durante la fase più intensa del conflitto. Tale fenomeno di degrado non manifesta segni di ripresa, evidenziando un ulteriore e progressivo peggioramento nel 2026.

<img src="Immagini/NDVI_anni.png" width="800">

### Calcolo della differenza multitemporale dell'NDVI
Per analizzare l'evoluzione temporale dell'area di studio, viene calcolata la differenza tra NDVI, permettendo di mappare il gradiente di variazione del vigore vegetale, dove i valori negativi evidenziano i processi di degrado ambientale avvenuti negli anni.

````r
dif_22_21 <- ndvi_2022 - ndvi_2021 # Differenza tra il 2022 e il 2021
dif_26_22 <- ndvi_2026 - ndvi_2022 # Differenza tra il 2026 e il 2022
dif_26_21 <- ndvi_2026 - ndvi_2021# Differenza totale sull'intero periodo analizzato

#Suddivisione dell'interfaccia grafica in una riga e tre colonne 
im.multiframe(1,3)
plot(dif_22_21, col=inferno(100), main="dif_NDVI_2022-2021") #Visualizzazione della differenza tra l'anno 2022 e 2021
plot(dif_26_22, col=inferno(100), main="dif_NDVI_2026-2022") #Visualizzazione della differenza tra l'anno 2026 e 2022
plot(dif_26_21, col=inferno(100), main="dif_NDVI_2026-2021") #Visualizzazione della differenza tra l'anno 2026 e 2021
````
<img src="Immagini/dif_NDVI.png" width="800">  
Le mappe di differenza evidenziano un'elevata frammentazione spaziale con valori che vanno da ± 1. Si osserva che un'alternanza tra fasi di degrado tra il 2021 e 2023, con un successivo peggioramento nel 2026.

### Analisi statistica della densità di distribuzione dell'NDVI
Al fine di poter valutare quantitativamente le variazioni spaziali osservate nei cartogrammi dell'NDVI e nelle relative mappe differenzali, viene utilizzata l'analisi statistica della distribuzione dei valori dei pixel per ciascun anno. A tale scopo, viene utilizzato il grafico a cresta (ridgeline plot), uno strumento specifico per il confronto multitemporale immediato della densità dei dati. Per osservare la variazione temporale continua in un unico grafico, i singoli layer raster dell'NDVI vengono uniti in uno stack.

````r
# Creazione dello stack dei tre NDVI e generazione del ridgeline plot
ndvi_stack <- c(ndvi_2021, ndvi_2022, ndvi_2026)
names(ndvi_stack) <- c("NDVI_2021", "NDVI_2022", "NDVI_2026") # Assegnazione nomi ai layer

im.ridgeline(ndvi_stack, scale=1, palette="viridis")  # Generazione di un ridgeline plot
````
<img src="Immagini/rifgline.png" width="800">  

Il grafico mostra chiaramente l'evoluzione temporale della distribuzione dell'NDVI per gli anni 2021, 2022 e 2026.
Il grafico evidenzia: 

- **2021** : la distribuzione è sbilanciata verso destra con un picco acuto verso lo 0.9, indicando una forte prevalenza di vegetazione densa.
- **2022** : si individua uno spostamento della massa verso valori intorno a 0.4 con una parziale riduzione del picco massimo di vigore rispetto al 2021.
- **2026** : La distribuzione subisce una contrazione drastica e un netto spostamento verso sinistra. Il picco si sposta verso valori dello 0.25, con una scomparsa di valori >0.7 (componente di vegetazione ad alto vigore)

## Classificazione 
Tramite la classificazione è possibile stabilire la frequenza della copertura vegetazionale e quella del suolo nudo. Per questo studio è stata scelta una classificazione a due classi.

````r
# Classificazione in 2 cluster (es. 1 = Vegetazione, 2 = suolo nudo )
class_2021 <- im.classify(ndvi_2021, seed=42, num_clusters=2 ) #Classificazione dell'NDVI del 2021 
class_2022 <- im.classify(ndvi_2022, seed=42, num_clusters=2 ) #Classificazione dell'NDVI del 2022
class_2026 <- im.classify(ndvi_2026, seed=42, num_clusters=2 ) #Classificazione dell'NDVI del 2026
````
<img src="Immagini/Classidicazione_senza_legenda.png" width="800">

````r
# Definizione della legenda a due classi(vegetazione, suolo nudo)
levels(class_2021) <- data.frame( value = c(2, 1), label = c("vegetazione", "suolo nudo"))
levels(class_2022) <- data.frame( value = c(2, 1), label = c("vegetazione", "suolo nudo"))
levels(class_2026) <- data.frame( value = c(2, 1), label = c("vegetazione", "suolo nudo"))

#visualizzazione della Classificazione
im.multiframe(1,3) #divisione dell'interfaccia grafica in un riga e tre colonne 
plot(class_2021, main="2021") #visualizzazione classi 2021
plot(class_2022, main="2022") #visualizzazione classi 2022
plot(class_2026, main="2026") #visualizzazione classi 2026
````
<img src="Immagini/Area_classificata.png" width="800">
Per confermare ciò che viene visualizzato vengono calcolate le frequenze percentuali 

````r
# calcolo delle frequenza assoluta 
f2021 <- freq(class_2021) # calcolo delle classi di vegetazione e suolo nudo 2021 
f2022 <- freq(class_2022) # calcolo delle classi di vegetazione e suolo nudo 2022
f2026 <- freq(class_2026) # calcolo delle classi di vegetazione e suolo nudo 2026

#calcolo delle frequenza relativa 
prop2021 <- f2021$count / ncell(class_2021) # frequenza assoluta diviso numero di celle del 2021 
prop2022 <- f2022$count / ncell(class_2022) # frequenza assoluta diviso numero di celle del 2022
prop2026 <- f2026$count / ncell(class_2026) # frequenza assoluta diviso numero di celle del 2026 

#conversione in dati percentuali 
perc2021 <- prop2021 * 100 #2021
perc2022 <- prop2022 * 100 #2022
perc2026 <- prop2026 * 100 #2026
````
Per una visualizzazione diretta viene generata una tabella.

````r
#creazione di una tabella con i dati calcolati 
tabella <- data.frame(
  class = c("suolo nudo", "vegetazione"),
  percentuale_2021 = perc2021,
  percentuale_2022 = perc2022,
  percentuale_2026 = perc2026
) # creazione di una tabella contenente le percentuali di suolo nudo e di vegetazione per ogni anno 

# Visualizzazione della tabella finale
tabella
````
| class | percentuale_2021 | percentuale_2022 | percentuale_2026 |
| :--- | :---: | :---: | :---: |
| **suolo nudo** | 27.64959 | 35.74551 | 51.67242 |
| **vegetazione** | 72.35041 | 64.25449 | 48.32796 |

Come si può vedere dai dati ottenuti la vegetazione ha avuto un forte calo di circa l' 8% nel 2022 a causa del conflitto  con un ulteriore calo nel 2026 con un valore di circa del 24% rispetto al 2021.
Con i dati forniti dalla tabella prodotta vengono generati tre grafici a barre.

````r
p1 <- ggplot(tabella, aes(x=class, y=percentuale_2021, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100)) + 
  labs(title="Copertura 2021", x="Classe", y="Percentuale (%)") +
  theme(legend.position="none")

p2 <- ggplot(tabella, aes(x=class, y=percentuale_2022, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100)) + 
  labs(title="Copertura 2022", x="Classe", y="Percentuale (%)") +
  theme(legend.position="none")

p3 <- ggplot(tabella, aes(x=class, y=percentuale_2026, color=class)) + 
  geom_bar(stat="identity", fill="white") + 
  ylim(c(0,100)) + 
  labs(title="Copertura 2026", x="Classe", y="Percentuale (%)") +
  theme(legend.position="none")

# Visualizzazione a schermo dei grafici affiancati
p1 + p2 + p3
````
<img src="Immagini/grafico.png" width="800">


# Conclusioni 
Lo studio condotto tramite telerilevamento satellitare multitemporale ha permesso di quantificare e confrontare l'evoluzione del danno ambientale nella regione di Zaporizhzhia tra il 2021 e il 2026. L'integrazione degli indici spettrali (DVI e NDVI), dell'analisi statistica della densità dei pixel mediante ridgeline plot e della classificazione finale ha evidenziato un processo di degrado continuo e cumulativo del territorio.
I risultati analitici mostrano che i danni non sono riconducibili esclusivamente al periodo iniziale del conflitto nel 2022, sono associati a una significativa diminuzione della biomassa fotosinteticamente attiva.
Nel 2026 il suolo nudo è diventato la matrice dominante con una copertura di circa il 51,67% della copertura totale mentre la vegetazione scende ad una copertura di circa il 48.33% confermando i gravi danni ecologici che si stanno susseguendo nel territorio ucraino. 
# 🌐 Sitografia 
## Contesto storico e geopolitico 
- **La Repubblica** *"Ucraina, forze russe occupano la centrale nucleare di Zaporizhzhia dopo l'attacco della notte"* (Pubblicato il 4 marzo 2022). Articolo giornalistico che documenta l'attacco militare e l'occupazione dell'area della centrale di Zaporizhzhia, evento cardine che ha determinato l'inizio delle ostilità nella zona e il conseguente abbandono delle attività agricole nel territorio circostante. Disponibile al link: https://www.repubblica.it/esteri/2022/03/04/news/ucraina_russi_zaporizhzhia-340217401/
### Piattaforme dati e librerie software
- **Google Earth Engine:** https://earthengine.google.com/ (Piattaforma cloud per il pre-processing e l'estrazione dei dati raster).
- **CRAN Repository:** https://cran.r-project.org/ (Documentazione ufficiale dei pacchetti R utilizzati: `terra`, `ggplot2`, `ggridges`, `viridis`).
- **Copernicus Data Space Ecosystem:** https://dataspace.copernicus.eu/ (Consultato per la verifica delle specifiche tecniche, delle lunghezze d'onda e delle risoluzioni geometriche delle bande spettrali di Sentinel-2).
















