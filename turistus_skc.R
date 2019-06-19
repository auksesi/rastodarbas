getwd()
setwd("/Users/Aukse/Desktop/turizmas")
if(!require(eurostat)) install.packages("eurostat") ; require(eurostat)
if(!require(tidyverse)) install.packages("tidyverse") ; require(tidyverse)
if(!require(rsdmx)) install.packages("rsdmx") ; require(rsdmx)
if(!require(openxlsx)) install.packages("openxlsx") ; require(openxlsx)
if(!require(dplyr)) install.packages("dplyr") ; require(dplyr)
if(!require(ggplot2)) install.packages("ggplot2") ; require(ggplot2)
if(!require(tidyr)) install.packages("tidyr") ; require(tidyr)



#Duomenu failo atsiuntimas ir issaugojimas


#url <- "https://osp-rs.stat.gov.lt/rest_xml/dataflow/"
#meta <- as.data.frame(meta)
#write.xlsx(meta, "LSD_meta.xlsx")

################################
#Duomenu parsiuntimas is LSD, ju redagavimas(suvienodinimas)
# S8R500_M4091505_1	 - Vietinių turistų skaičius	
#Suminis (2004 - 2017) 
VIETINIAI <- readSDMX(providerId ="LSD", 
                      resource = "data", 
                      flowRef = "S8R500_M4091505_1", 
                      dsd= TRUE)
VIETINIAI <- as.data.frame(VIETINIAI)
VIETINIAI <- VIETINIAI %>% filter(LAIKOTARPIS > "2006-01-01") 


ATVYKE <- readSDMX(providerId ="LSD", 
                   resource = "data", 
                   flowRef = "S8R701_M4091301_1", 
                   dsd= TRUE)
ATVYKE <- as.data.frame(ATVYKE)
ATVYKE <- ATVYKE %>% filter(LAIKOTARPIS > "2006-01-01")

ISVYKE <- readSDMX(providerId ="LSD", 
                   resource = "data", 
                   flowRef = "S8R709_M4091101_1", 
                   dsd= TRUE)
ISVYKE <- as.data.frame(ISVYKE)
ISVYKE <- ISVYKE %>% filter(LAIKOTARPIS > "2006-01-01")
#____________
#Sukursiu bendra duomenu lentele, kuri atvaizduotu turistu skaiciu Lietuvoje
dt<- data.frame(VIETINIAI, ISVYKE, ATVYKE)
dt <- dt %>% select(-c(1,4,5,6,8,9,10,12))

names(dt)[2]<-paste("Vietiniai")
names(dt)[3]<-paste("Isvyke")
names(dt)[4]<-paste("Atvyke")

#-----------------
#Sukursiu grafika atspindinti gauta duomenu lentele. 

ggplot(dt, aes(LAIKOTARPIS, y = value, color = Turistų_tipai)) + 
  geom_point(aes(y = Vietiniai, col = "Vietiniai")) + 
  geom_point(aes(y = Atvyke, col = "Atvyke"))+
  geom_point(aes(y = Isvyke, col = "Isvyke"))+
  labs(title = "Išvykusių, atvykusių ir vietinių turistų skaičius Lietuvoje 2007m-2017m.",
       subtitle = "Lietuvos statistikos departamentas",
       x="Metai", y = "Turistų skaičius")



