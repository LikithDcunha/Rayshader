install.packages('extrafont')
install.packages('magick')

library(magick)
library(MetBrewer)
library(colorspace)
library(glue)
library(stringr)
library(ggplot2)
library(extrafont)

loadfonts(device = "all", quiet = TRUE) ## load the fonts from your system

read_ber_brand <- image_read('images/final_ber_brand.png')

colors <- met.brewer("Tam")
swatchplot(colors)
text_color <- darken(colors[5],.25)
swatchplot(text_color)


annote_berlin <- glue("Population estimates are bucketed into 400 meter (about 1/4 mile) ",
                      "hexagons.") |> 
  str_wrap(40)

footer <- glue("By Likith DCunha | ",
               "Data: Kontur Population (Released 2022-06-30) | ",'inspired by: Spencer Schien ')

read_ber_brand |>
  image_crop(gravity = 'center',
             geometry = '5000x4500') |>
  image_annotate("Berlin-Brandenberg, Germany",
                 gravity = "northwest",
                 location = "+650+500",
                 color = text_color,
                 size = 250,
                 weight = 700,
                 font = "DIN 1451 Mittelschrift") |>
  image_annotate("Population Density Map",
                 gravity = "northwest",
                 location = "+650+350",
                 color = text_color,
                 size = 120,
                 weight = 700,
                 font =  "DIN 1451 Mittelschrift")|>
  image_annotate(annote_berlin,
                 gravity = "west",
                 location = "+600+1300",
                 color = text_color,
                 size = 100,
                 font = "DIN 1451 Mittelschrift") |>
  image_annotate(footer,
                 gravity = "south",
                 location = "+0+100",
                 font = "DIN 1451 Mittelschrift",
                 color = alpha(text_color, .5),
                 size = 80) |>
  image_write("images/titled_ber-brand.png")
