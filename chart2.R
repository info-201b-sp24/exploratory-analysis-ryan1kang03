
## Mapping Citys and their emmissions flag rating 


# Load in 
library(tidyverse)
library(leaflet)
library(dplyr)
library(sf)
library(stringr)
library(ggplot2)


#setwd("/Users/annabellefallstrom/Desktop/INFO201/SCRIPTS-2/DATA")

climate_change <- read_excel("D_FINAL.xlsx")


  names(climate_change)[names(climate_change) == "Emissions Quality Flag (CDP)"] <- "emissions_quality_flag_cdp"
  names(climate_change)[names(climate_change) == "Latitude (others) [degrees]"] <- "latitude"
  names(climate_change)[names(climate_change) == "Longitude (others) [degrees]"] <- "longitude"
  

palette_fn <- colorFactor(palette = "Set2", domain = climate_change$emissions_quality_flag_cdp)

palette <- colorFactor(palette = c("darkseagreen2", "darkseagreen", "darkolivegreen","darkgreen", "black"),
                       levels = c("A", "B", "C", "D", "E"), na.color = "grey")


chart2 <- climate_change %>%
  leaflet() %>%

    addCircleMarkers(
                     label = ~emissions_quality_flag_cdp,
                     stroke = FALSE,
                     fillColor = ~palette(emissions_quality_flag_cdp),
                     fillOpacity = 3,
                     radius = 2) %>% 

  addTiles() %>%
  addLegend(position ="bottomleft",
            pal = palette,
            values = ~emissions_quality_flag_cdp,
            title = "Emmissions Flag Rating by City in YEAR")
