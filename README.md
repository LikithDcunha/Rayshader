# Population Density of Berlin and Brandenburg using Rayshader Package in R

This repository contains the code and files to create a 3D visualization of population density using Rayshader package in R for Berlin and Brandenburg, Germany.

Required Packages
Before starting the code, you need to install and load the following packages:

rayshader
rgdal
dplyr
ggplot2
sf
sp
Data
The data used for this visualization is obtained from the kontur database Berlin/Brandenburg (https://data.humdata.org/dataset/kontur-population-dataset). The shapefile used contains population density data for the year 2022.

## Code
The R code used to create the visualization is available in the main.R file.

The script does the following:

Load the required packages
Load and clean the shapefile data
Convert the shapefile data to a raster format
Use rayshader package to create 3D visualization of population density
Output
The output of the script is a 3D visualization of population density for Berlin and Brandenburg.
The output is saved in the images folder.


How to Use
To use this code, follow these steps:

Clone or download this repository to your local machine.
Install the required packages mentioned above.
Open main.R and run the code.
The output files will be saved in the iamges folder.



# Graphics

![Berlin-Brandenberg](https://github.com/LikithDcunha/Rayshader/blob/development/images/titled_ber-brand.png)
![Brandenberg](https://github.com/LikithDcunha/Rayshader/blob/development/images/titled_brand.png)
