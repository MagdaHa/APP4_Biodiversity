#######################
#### preprocessing ####
#######################


# function, which works with a raster stack and does:
# - same spatial resolution for every raster
# - same spatial extent for every raster
# - calculates NDVI


#Raster stack with:
# - NDVI
# - Sentinel2/Landsat8
# - Nightlights
# - DEM
# - temperature
# - precipitation
# - slope
# - urban footprint
# - infrastructure


library(sp)
library(raster)


outputdir <- "C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\"

#---------------------------------------
#only to do the first time
#########NDVI 2019#############
#load bands
NIR <- raster("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\2019_R10m\\T32UPA_20190716T102031_B08_10m.jp2")
RED <- raster("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\2019_R10m\\T32UPA_20190716T102031_B04_10m.jp2")

#function NDVI
NDVI <- function(NIR, RED){
  return((NIR - RED)/(NIR + RED))
}

NDVI <- NDVI(NIR, RED)
plot(NDVI)

#write raster NDVI
writeRaster(NDVI,paste0(outputdir,"NDVI_S2_20190716"),"GTiff",overwrite=TRUE)
#--------------------------------------


NDVI_load <- raster("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\NDVI_S2_20190716.tif")
plot(NDVI_load)


#only to do the first time
#########NDVI 2018#############
#load bands
NIR <- raster("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\2018_R10m\\T32UNA_20180701T102021_B08.jp2")
RED <- raster("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\2018_R10m\\T32UNA_20180701T102021_B04.jp2")

#function NDVI
NDVI <- function(NIR, RED){
  return((NIR - RED)/(NIR + RED))
}

NDVI <- NDVI(NIR, RED)
plot(NDVI)

#write raster NDVI
writeRaster(NDVI,paste0(outputdir,"NDVI_S2_20180701"),"GTiff",overwrite=TRUE)
#--------------------------------------

