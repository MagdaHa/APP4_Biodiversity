####
#
####

library(rgdal)
library(raster)

source("R\\prepare_datasets.R")

aoi_path <- "C:\\Users\\sandr\\Documents\\EAGLE_Data\\WS201819_1st_Term\\04GEOMB1_Digital_Image_Analysis\\Steigerwald\\02_vector\\01_landcover\\corine\\CLC_2012\\clc_12.shp"
forest_border <- readOGR(aoi_path)

bio <- raster::getData("worldclim", var = "bio", res = 0.5, lon = 10.55, lat = 49.9)
savi <- raster("C:\\Users\\sandr\\Documents\\EAGLE_Data\\WS201819_1st_Term\\04GEOMB1_Digital_Image_Analysis\\Steigerwald\\03_raster\\01_landsat\\01_indices\\LC8_savi.grd")
ndmi <- raster("C:\\Users\\sandr\\Documents\\EAGLE_Data\\WS201819_1st_Term\\04GEOMB1_Digital_Image_Analysis\\Steigerwald\\03_raster\\01_landsat\\01_indices\\LE7_ndmi.grd")
nbr <- raster("C:\\Users\\sandr\\Documents\\EAGLE_Data\\WS201819_1st_Term\\04GEOMB1_Digital_Image_Analysis\\Steigerwald\\03_raster\\01_landsat\\01_indices\\LT4_nbr.grd")
guf <- raster("C:\\Users\\sandr\\Documents\\EAGLE_Data\\WS201819_1st_Term\\04GEOMB1_Digital_Image_Analysis\\Steigerwald\\03_raster\\06_urbanfootprint\\GUF_EAGLE_AOI.tif")
corine_lc <- readOGR("C:\\Users\\sandr\\Documents\\EAGLE_Data\\WS201819_1st_Term\\04GEOMB1_Digital_Image_Analysis\\Steigerwald\\02_vector\\01_landcover\\corine\\CLC_2012\\clc_12.shp")

corine_lc <- rasterize(corine_lc, savi, field='clc_legend')

datasets <- list(savi, ndmi, nbr, guf, bio[[1]], bio[[5]], bio[[6]], bio[[12]], corine_lc)

ready_data <- prepare_dataset(datasets, aoi = forest_border)
for (i in 1:8) {message(res(ready_data[[i]]))}
