prepare_dataset <- function(datasets, aoi, res=c(30,30), projstr="+init=epsg:4326", mask=F) {
  
  # crop
  for (i in length(datasets)) {
    datasets[[i]] <- raster::crop(datasets[[i]], aoi)
    message(paste0("Cropped raster: ", datasets[[i]]@file@name))
    if(mask == T){
      datasets[[i]] <- raster::mask(datasets[[i]], aoi)
      message(paste0("Masked raster: ", datasets[[i]]@file@name))
    }
  }
  
  # project
  for (i in length(datasets)) {
    datasets[[i]] <- projectRaster(datasets[[i]], crs = CRS(projstr), res = res)
    message(paste0("Projected raster: ", datasets[[i]]@file@name))
  }
  
  # resample
  for (i in length(datasets)) {
    datasets[[i]] <- raster::resample(datasets[[i]], datasets[[1]])
    message(paste0("Projected raster: ", datasets[[i]]@file@name))
  }
  
  #stack
  #names?
  
  return(datasets)
}

