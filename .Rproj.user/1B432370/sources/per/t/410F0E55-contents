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

library(usethis)
library(eurostat)


# Load kontur data 
data <- st_read("data/kontur_population_DE_20220630.gpkg")

# load europe data from eurostat library
de_states <- get_eurostat_geospatial(resolution = "20", nuts_level = 1, 
                                     year = 2021)



## filter Berlin
berlin <- de_states |>
  filter(NUTS_NAME == "Berlin" )


# filter brandenberg
brandenberg <- de_states |>
  filter(NUTS_NAME == "Brandenburg")

# plot berlin brandenberg

plot_berlin_brand <- berlin |>
  ggplot()+
  geom_sf()+
  geom_sf(data = berlin$geometry)+
  geom_sf(data = brandenberg$geometry)

plot_berlin_brand





# plot brandenberg
# plot_brandenberg <- brandenberg |> 
#   ggplot()+geom_sf() +  
#   geom_sf(data = brandenberg$geometry)
# 
# plot_brandenberg


# transform the CRS data of Brandenberg to Kontur Data to get an intersection

brandenberg <- st_transform(brandenberg, crs= st_crs(data))

berlin <- st_transform(berlin,crs = st_crs(data))



# intersect the geospatial data with florida to limit kontur data to only desired boundary
final_map <- st_union(berlin, brandenberg)

st_map_ber_brand_data <- st_intersection(data, st_final_map)

# Plotting to check population data on map # plot the intersection data 
p1 <- st_map_ber_brand_data |>
  ggplot() + geom_sf()

p1





# define an aspect ratio based on  the bounding box 

bb <- st_bbox(st_map_ber_brand_data)


# take corner points based on bounding box data

bottom_left <- st_point(c(bb[['xmin']], bb[['ymin']])) |> 
  st_sfc(crs = st_crs(data))

bottom_right <- st_point(c(bb[['xmax']], bb[['ymin']])) |> 
  st_sfc(crs= st_crs(data))

# check by plotting the graph
final_map |> 
  ggplot() + 
  geom_sf() + 
  geom_sf(data = bottom_left) + 
  geom_sf(data = bottom_right, color = 'red')


top_left <- st_point(c(bb[['xmin']], bb['ymax'])) |> 
  st_sfc(crs = st_crs(data))

# Calculate width and height (units mtrs)

width <- st_distance(bottom_left, bottom_right)    

height <- st_distance(bottom_left, top_left)



# handle conditions for height or width being the longer side  
if (width > height) {
  w_ratio <- 1
  h_ratio <- height / width
} else { 
  h_ratio <- 1
  w_ratio <- width / height 
}

# Set a size for resolution
size <- 4000

# glimpse(st_brandenberg)

# convert to raster so that we can convert to matrix

final_raster <- st_rasterize(st_map_ber_brand_data, 
                             nx = floor(size* as.numeric(w_ratio)),
                             ny = floor(size*as.numeric(h_ratio)))




# convert to matrix

matrix_final <- matrix(final_raster $population, 
                       nrow = floor(size* w_ratio),
                       ncol = floor(size*h_ratio))



# color pallete with metbrewer and colorspace packages
color_map <- met.brewer('Tam')
swatchplot(color_map)



texture <- grDevices::colorRampPalette(color_map, bias=2.5)(256)
swatchplot(texture)



# plot that map on 3d with rgl object 

rgl:: rgl.close()           # close the rgl window after test render 




matrix_final |> 
  height_shade(texture = texture) |> 
  plot_3d(heightmap = matrix_final,
          zscale = 100/4,
          solid = FALSE,
          shadowdepth = 0)


render_camera(theta = 0, phi = 45, zoom = .8)


# test plot 

# render_highquality(filename = 'images/test_plot.png',
#                    interactive = FALSE,
#                    lightdirection = 280,
#                    lightaltitude = c(20, 80),
#                    lightcolor = c(color_map[2], "white"),
#                    lightintensity = c(600, 100))



outfile_1 <- "images/final_ber_brand.png"

{
  start_time <- Sys.time()
  cat(crayon::cyan(start_time), "\n")
  if (!file.exists(outfile_1)) {
    png::writePNG(matrix(1), target = outfile)
  }
  render_highquality(
    filename = outfile_1,
    interactive = FALSE,
    lightdirection = 280,
    lightaltitude = c(20, 80),
    lightcolor = c(color_map[2], "white"),
    lightintensity = c(600, 100),
    samples = 450,
    width = 6000,
    height = 6000
  )
  end_time <- Sys.time()
  cat(crayon::cyan(end_time), "\n")
  diff <- end_time - start_time
  cat(crayon::cyan(diff), "\n")
}




