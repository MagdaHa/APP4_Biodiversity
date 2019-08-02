library(raster)
library(rgdal)
library(tidyverse)

setwd("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data")

s2_LAI <- stack("LAI_S2_20192018_change.tif")
s2_NDVI <- stack("NDVI_S2_20192018_change.tif")

plots_buff <- readOGR("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\Plot_Shape\\plot_buffer.shp")
plots_buff <- spTransform(plots_buff, s2_LAI@crs)

#------------------------------------
### LAI
j <- 1
for(i in plots_buff$PlotId){
  
  # extract plot buffer polygon
  poi_tmp <- plots_buff[plots_buff$PlotId == i,]
  buff <- raster::mask(s2_LAI,poi_tmp)
  
  # calculate mean value for this POI-buffer for all years (= raster layers)
  mean_sig0 <- raster::cellStats(buff,stat="median", na.rm=T)
  
  # convert to tibble and add columns with relevant station and date_flag information
  mean_sig0 <- tibble::as_tibble(mean_sig0)
  mean_sig0 <- tibble::add_column(mean_sig0,plot_id=i,x=poi_tmp$POINT_X,y=poi_tmp$POINT_Y,block=poi_tmp$Block,distr=poi_tmp$Verteilung,treat=poi_tmp$Treatment)
  
  # add to tibble with all plots
  if(j==1){ # 1st layer
    ras_mean <- mean_sig0
  } else {
    ras_mean <- dplyr::bind_rows(ras_mean,mean_sig0)
  }
  
  # counter
  j <- j+1
  
} # end for through stations

View(ras_mean)
ras_mean_LAI <- ras_mean
write.csv(ras_mean_LAI,"ras_median_LAI.csv")
rm(ras_mean)

#------------------------------
### NDVI
j <- 1
for(i in plots_buff$PlotId){
  
  # extract plot buffer polygon
  poi_tmp <- plots_buff[plots_buff$PlotId == i,]
  buff <- raster::mask(s2_NDVI,poi_tmp)
  
  # calculate mean value for this POI-buffer for all years (= raster layers)
  mean_sig0 <- raster::cellStats(buff,stat="median", na.rm=T)
  
  # convert to tibble and add columns with relevant station and date_flag information
  mean_sig0 <- tibble::as_tibble(mean_sig0)
  mean_sig0 <- tibble::add_column(mean_sig0,plot_id=i,x=poi_tmp$POINT_X,y=poi_tmp$POINT_Y,block=poi_tmp$Block,distr=poi_tmp$Verteilung,treat=poi_tmp$Treatment)
  
  # add to tibble with all plots
  if(j==1){ # 1st layer
    ras_mean <- mean_sig0
  } else {
    ras_mean <- dplyr::bind_rows(ras_mean,mean_sig0)
  }
  
  # counter
  j <- j+1
  
} # end for through stations

View(ras_mean)
ras_mean_NDVI <- ras_mean
write.csv(ras_mean_NDVI,"ras_median_NDVI2.csv")

#-------------------------------
### correlations

#NDVI
plot(ras_mean_NDVI$distr, ras_mean_NDVI$value)
ggplot(data=ras_mean_NDVI, aes(x=distr, y=value))+
  geom_boxplot()+
  xlab("distribution")+
  ylab("NDVI change")

plot(ras_mean_NDVI$treat, ras_mean_NDVI$value)
ggplot(data=ras_mean_NDVI, aes(x=treat, y=value))+
  geom_boxplot()+
  xlab("treatment")+
  ylab("NDVI change")

#LAI
plot(ras_mean_LAI$distr, ras_mean_LAI$value)
ggplot(data=ras_mean_LAI, aes(x=distr, y=value))+
  geom_boxplot()+
  xlab("distribution")+
  ylab("LAI change")

ggplot(data=ras_mean_LAI, aes(x=treat, y=value))+
  geom_boxplot()+
  xlab("treatment")+
  ylab("LAI change")


