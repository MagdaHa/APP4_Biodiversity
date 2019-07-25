####
#
####

library(rgdal)
library(raster)

source("R\\prepare_datasets.R")

aoi_path <- "C:\\Users\\sandr\\Documents\\EAGLE_Data\\WS201819_1st_Term\\04GEOMB1_Digital_Image_Analysis\\Steigerwald\\02_vector\\01_landcover\\corine\\CLC_2012\\clc_12.shp"
forest_border <- readOGR(aoi_path)

aoi <- readOGR("C:\\02_Studium\\02_Master\\01_Semester 1\\MB1_Digital Image Analysis and GIS_Hüttich\\04_data\\Steigerwald\\02_vector\\03_forest\\02_forest_border\\forest_border_utm32N.shp")
bio <- raster::getData("worldclim", var = "bio", res = 0.5, lon = 10.55, lat = 49.9)
NDVI <- raster("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\NDVI_S2_20190716.tif")
savi <- raster("C:\\Users\\sandr\\Documents\\EAGLE_Data\\WS201819_1st_Term\\04GEOMB1_Digital_Image_Analysis\\Steigerwald\\03_raster\\01_landsat\\01_indices\\LC8_savi.grd")
ndmi <- raster("C:\\Users\\sandr\\Documents\\EAGLE_Data\\WS201819_1st_Term\\04GEOMB1_Digital_Image_Analysis\\Steigerwald\\03_raster\\01_landsat\\01_indices\\LE7_ndmi.grd")
nbr <- raster("C:\\Users\\sandr\\Documents\\EAGLE_Data\\WS201819_1st_Term\\04GEOMB1_Digital_Image_Analysis\\Steigerwald\\03_raster\\01_landsat\\01_indices\\LT4_nbr.grd")
guf <- raster("C:\\Users\\sandr\\Documents\\EAGLE_Data\\WS201819_1st_Term\\04GEOMB1_Digital_Image_Analysis\\Steigerwald\\03_raster\\06_urbanfootprint\\GUF_EAGLE_AOI.tif")
corine_lc <- readOGR("C:\\Users\\sandr\\Documents\\EAGLE_Data\\WS201819_1st_Term\\04GEOMB1_Digital_Image_Analysis\\Steigerwald\\02_vector\\01_landcover\\corine\\CLC_2012\\clc_12.shp")
corine_lc <- rasterize(corine_lc, savi, field='clc_legend')
dgm <- raster("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\DGM25_SAGA_TWI_POPEN_SLOPE.tif")
geology <- readOGR("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\Geologie_200\\GK200_BGR_Sailershausen.shp")


datasets <- list(savi, ndmi, ndvi_load, nbr, guf, bio[[1]], bio[[5]], bio[[6]], bio[[12]], corine_lc)

ready_data <- prepare_dataset(datasets, aoi = forest_border)
for (i in 1:8) {message(res(ready_data[[i]]))}

#---------same CRS/projection--------------#
datasets <- projectRaster(datasets, crs = CRS(projstr), res = res)




#---------crop to extent of study area--------------#
NDVI_crop <- raster::crop(NDVI, aoi)
DGM_crop <- raster::crop(dgm, aoi)
corine_crop <- raster::crop(corine_lc, aoi)
geology_crop <- raster::crop(geology, aoi)
