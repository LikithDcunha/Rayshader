library(rayshader)
library(rayrender)
library(sf)
library(tigris)
library(rgl)
library(sp)
library(raster)
library(tigris)
library(tidyverse)
library(stars)
library(MetBrewer)
library(colorspace)
library(rayrender)
library(rnaturalearth)
library(dplyr)



st_provinces <- st_read("data/India_State_Boundary.shp")




india <- ne_download(type = "map_units", category = "cultural", 
                     returnclass = "sf",load =  TRUE)



india_map <-  india |>
  filter(NAME_EN == "India")

p_india <- india_map |> 
  ggplot()+
  geom_sf(data = india_map$geometry)

p_india

india_states <- ne_download(type = "map_units", category = "cultural",
                            returnclass = "sf")

states <- india_states |> 
  filter(ADMIN == 'India')

glimpse(states)

karnataka <- india_states %>%
  filter(name_en == "Karnataka")
