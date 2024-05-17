library("readxl")
library("tidyverse")
library("ggplot2")
library("dplyr")
CO2_data <- read_excel("~/D_FINAL.xlsx")

data <- CO2_data %>%
  rename(
    City_name = "City name",
    Reporting_year = "Reporting year (CDP)",
    S1_GHG_emissions = "Scope-1 GHG emissions [tCO2 or tCO2-eq]",
    Year_of_emission = "Year of emission",
    Population = "Population (others)",
    S2_GHG_emissions = "Scope-2 (CDP) [tCO2-eq]",
    Total_emissions = "Total emissions (CDP) [tCO2-eq]",
    Emissions_Quality_Flag = "Emissions Quality Flag (CDP)"
    ) %>% 
  mutate(location = paste(City_name, Country, sep = ", "))

c_data <- data %>%
  select(c(location, Population, Reporting_year, S1_GHG_emissions, Year_of_emission, S2_GHG_emissions, Total_emissions, Emissions_Quality_Flag)) 

c_data_na <- c_data %>%
  filter(!is.na(Total_emissions))

sort <- sort %>%
  mutate(Emissions_per_person = round(Total_emissions/Population, 2)) %>%
  group_by(Emissions_Quality_Flag)

sort <- sort[order(sort$Emissions_per_person), , drop = FALSE]
sort <- sort[order(sort$Emissions_Quality_Flag), , drop = FALSE]
