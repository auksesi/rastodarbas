getwd()
setwd("/Users/Aukse/Desktop/turizmas")
if(!require(eurostat)) install.packages("eurostat") ; require(eurostat)
if(!require(tidyverse)) install.packages("tidyverse") ; require(tidyverse)
if(!require(rsdmx)) install.packages("rsdmx") ; require(rsdmx)
if(!require(openxlsx)) install.packages("openxlsx") ; require(openxlsx)
if(!require(dplyr)) install.packages("dplyr") ; require(dplyr)
if(!require(ggplot2)) install.packages("ggplot2") ; require(ggplot2)
if(!require(tidyr)) install.packages("tidyr") ; require(tidyr)
if(!require(knitr)) install.packages("knitr") ; require(knitr)

#Duomenu failo atsiuntimas ir issaugojimas
# Sukursiu duomenu lenteles visu grupiu turistu islaidu skaiciu
islaidos_vtn <- readSDMX(providerId ="LSD", 
                      resource = "data", 
                      flowRef = "S8R495_M4091505_2", 
                      dsd= TRUE)
islaidos_vtn <- as.data.frame(islaidos_vtn)
islaidos_vtn <- islaidos_vtn %>% filter(LAIKOTARPIS > "2006-01-01") 

islaidos_atvk <- readSDMX(providerId ="LSD", 
                         resource = "data", 
                         flowRef = "S8R694_M4091301_3", 
                         dsd= TRUE)
islaidos_atvk<- as.data.frame(islaidos_atvk)
islaidos_atvk <- islaidos_atvk %>% filter(LAIKOTARPIS > "2006-01-01") 

islaidos_isvk <- readSDMX(providerId ="LSD", 
                          resource = "data", 
                          flowRef = "S8R706_M4091101_3", 
                          dsd= TRUE)
islaidos_isvk<- as.data.frame(islaidos_isvk)
islaidos_isvk <- islaidos_isvk %>% filter(LAIKOTARPIS > "2006-01-01")

dt<- data.frame(VIETINIAI, ISVYKE, ATVYKE)
#-------
# Sukursiu duomenu lenteles visu grupiu turistu dienos islaidu sumai
vidut_dienos_vtn <- readSDMX(providerId ="LSD", 
                           resource = "data", 
                           flowRef = "S8R501_M4091505_3", 
                           dsd= TRUE)
vidut_dienos_vtn<- as.data.frame(vidut_dienos_vtn)
vidut_dienos_vtn <- vidut_dienos_vtn %>% filter(LAIKOTARPIS > "2006-01-01")


vidut_dienos_atvk <- readSDMX(providerId ="LSD", 
                             resource = "data", 
                             flowRef = "S8R698_M4091301_2", 
                             dsd= TRUE)
vidut_dienos_atvk<- as.data.frame(vidut_dienos_atvk)
vidut_dienos_atvk <- vidut_dienos_atvk %>% filter(LAIKOTARPIS > "2006-01-01")


vidut_dienos_isvk <- readSDMX(providerId ="LSD", 
                              resource = "data", 
                              flowRef = "S8R710_M4091101_2", 
                              dsd= TRUE)
vidut_dienos_isvk<- as.data.frame(vidut_dienos_isvk)
vidut_dienos_isvk <- vidut_dienos_isvk %>% filter(LAIKOTARPIS > "2006-01-01")

################################
#Sukursiu duomenu lenteles visu grupiu turistu vienos keliones vidutiniu islaidu sumai
vidut_keliones_vtn <- readSDMX(providerId ="LSD", 
                              resource = "data", 
                              flowRef = "S8R502_M4091505_3", 
                              dsd= TRUE)
vidut_keliones_vtn<- as.data.frame(vidut_keliones_vtn)
vidut_keliones_vtn <- vidut_keliones_vtn %>% filter(LAIKOTARPIS > "2006-01-01")

vidut_keliones_atvk <- readSDMX(providerId ="LSD", 
                               resource = "data", 
                               flowRef = "S8R697_M4091301_2", 
                               dsd= TRUE)
vidut_keliones_atvk<- as.data.frame(vidut_keliones_atvk)
vidut_keliones_atvk<- vidut_keliones_atvk %>% filter(LAIKOTARPIS > "2006-01-01")

vidut_keliones_isvk <- readSDMX(providerId ="LSD", 
                                resource = "data", 
                                flowRef = "S8R711_M4091101_2", 
                                dsd= TRUE)
vidut_keliones_isvk <- as.data.frame(vidut_keliones_isvk)
vidut_keliones_isvk <- vidut_keliones_isvk %>% filter(LAIKOTARPIS > "2006-01-01")




islaidos<- data.frame(islaidos_atvk, islaidos_isvk, islaidos_vtn)
islaidos <- islaidos%>% select(-c(1,4,5,6,8,9,10,12))
names(islaidos)[2]<-paste("Atvyke")
names(islaidos)[3]<-paste("Isvyke")
names(islaidos)[4]<-paste("Vietiniai")
islaidos <- islaidos %>% arrange(LAIKOTARPIS)
islaidos

vidut_dienos <- data.frame(vidut_dienos_atvk, vidut_dienos_isvk, vidut_dienos_vtn)
vidut_dienos <- vidut_dienos %>% select(-c(1,4,5,6,8,9,10,12))
names(vidut_dienos)[2]<-paste("Atvyke")
names(vidut_dienos)[3]<-paste("Isvyke")
names(vidut_dienos)[4]<-paste("Vietiniai")
vidut_dienos <- vidut_dienos %>% arrange(LAIKOTARPIS)


vidut_keliones <- data.frame(vidut_keliones_atvk, vidut_keliones_isvk, vidut_keliones_vtn)
vidut_keliones<- vidut_keliones %>% select(-c(1,4,5,6,8,9,10,12))
names(vidut_keliones)[2]<-paste("Atvyke")
names(vidut_keliones)[3]<-paste("Isvyke")
names(vidut_keliones)[4]<-paste("Vietiniai")
vidut_keliones <- vidut_keliones %>% arrange(LAIKOTARPIS)
