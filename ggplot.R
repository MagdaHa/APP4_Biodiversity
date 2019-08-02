library(ggplot2)
library(raster)
library(rgdal)
library(tidyverse)


x18_LAI <- raster("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\LAI_S2_20180701_mask.tif")
x19_LAI <- raster("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\LAI_S2_20190716_mask.tif")


plots <- readOGR("")

x18_extr <- extract(plots, x18_LAI)


plots_all <- readOGR("C:\\02_Studium\\02_Master\\02_Semester_2\\APP4_Biodiversity\\01_data\\Plot_Shape\\plot_buffer_NDVILAI.shp")
pa <- plots_all@data

names(pa)

summary(pa)

ggplot(data=pa, aes(x=X_LAI2019me, y=X_NDVI2019m, color=Treatment, size=Verteilung))+
  geom_point(alpha=.5)+
  scale_size_manual(values=c(3,6,9))+
  ylim(c(2.0,3.0))


ggsave("plots_treatment_2019.tiff")

ggplot(data=pa, aes(x=X_LAI2018me, y=X_NDVI2018m, color=Treatment, size=Verteilung))+
  geom_point(alpha=.5)+
  scale_size_manual(values=c(3,6,9))

ggsave("plots_treatment_2018.tiff")






p2018 <- ggplot(data=pa, aes(x=X_LAI2018me, y=X_LAI2019me, color=Treatment, size=Verteilung))+
  geom_point(alpha=.5)+
  scale_size_manual(values=c(3,6,9))+
scale_x_continuous(limits = c(2.2, 3.75)) + 
  scale_y_continuous(limits = c(2.2,3.75))

p2018

p2019 <-ggplot(data=pa, aes(x=X_NDVI2018m, y=X_NDVI2019m, color=Treatment, size=Verteilung))+
  geom_point(alpha=.5)+
  scale_size_manual(values=c(3,6,9))+
  scale_x_continuous(limits = c(0.75, 0.9)) + 
  scale_y_continuous(limits = c(0.75,0.9))
p2019

library(gridExtra)

grid.arrange(p2018,p2019, ncol=2)



install.packages("ggbiplot")


library(ggbiplot)
data(wine)
wine.pca <- prcomp(wine, scale. = TRUE)
ggbiplot(wine.pca, obs.scale = 1, var.scale = 1,
         groups = wine.class, ellipse = TRUE, circle = TRUE) +
  scale_color_discrete(name = '') +
  theme(legend.direction = 'horizontal', legend.position = 'top')


