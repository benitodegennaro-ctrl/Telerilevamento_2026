#codice per calssificare i dati 
library(terra)
library(viridis)
library(imageRy)
library(ggplot2)
library(patchwork)


#lista delle immagini 
im.list()
#impoirto il file del satellite solar horbiter
sun<-im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#classifico l'immagine in base ai suo livelli 
sun_c<-im.classify(sun)

sun_c<-im.classify(sun, seed=3)
sun_c<-im.classify(sun, seed=42)
#importo l'immagine del gran canion 
can<-im.import("dolansprings_oli_2013088_canyon_lrg.jpg")

#classificazione del dato del gran canion
can_c<-im.classify(can, seed=42, num_clusters=4)
#per sapere il numero di pixell
ncell(can)

setwd("~/Desktop/Magistrale")

#esempio del matogrosso 
im.list
m_06<-im.import("matogrosso_ast_2006209_lrg.jpg")
m_92<-im.import()
im.multiframe(1,2)
 plot(m_06)
plot(m_92)

#classificazione 1992
 mc_92<-im.classify(m_92, seed=42, num_cluster=2)
levels(mc_92) <- data.frame(
  value = c(1, 2),
  label = c("forest", "human")
)
#lo rifaccio per il 2006
mc_06<-im.classify(m_06, seed=42, num_cluster=2)
levels(mc_06) <- data.frame(
  value = c(2, 1),
  label = c("forest", 
)

#calcoliamo le frequenze 
freq(mc_92)
#frequenza %
freq(mc_92)/ncell(m_92)
#f1992
prop1992<-f_1992$count/ncell(mc_92)

f_2006<-freq(mc_06)
#frequenza %
freq(mc_92)/ncell(m_92)
#f1992
prop1992<-f_1992$count/ncell(mc_92)
tabella<-data.frame(
  class=c("foresta","umana")
          perc1992=c(83, 17),
          perc2006=c(54,45))
#per il 1992
p1<-ggplot(tabout, aes(x=class, y=perc1992, color=class))+ #struttura
 geom_bar(stat="identity", fill="white")+
 ylim(c(0,100))+
 theme(legend.position="none")
 
 #limite 
 #bar plot 
 
#per il 2006
p2<-ggplot(tabout, aes(x=class, y=perc2006, color=class))+ #struttura
 geom_bar(stat="identity", fill="white")+
 ylim(c(0,100))

 #limite 
 #bar plot
 
p1+p2
 
