# libraries
library("readxl")
library("dplyr")
library("ggplot2")

# load data
dataset <- read_excel("./D_FINAL.xlsx")

# value 1: top emissions producing countries
by_countries <- dataset %>%
  group_by(`Country`) %>%
  summarise(`Total emissions (CDP) [tCO2-eq]` = sum(`Total emissions (CDP) [tCO2-eq]`, na.rm = TRUE)) %>%
  filter(`Total emissions (CDP) [tCO2-eq]` != 0) %>%
  arrange(desc(`Total emissions (CDP) [tCO2-eq]`))

# value 2: top emissions producing regions
by_regions <- dataset %>%
  group_by(`Region`) %>%
  summarise(`Total emissions (CDP) [tCO2-eq]` = sum(`Total emissions (CDP) [tCO2-eq]`, na.rm = TRUE)) %>%
  filter(`Total emissions (CDP) [tCO2-eq]` != 0) %>%
  arrange(desc(`Total emissions (CDP) [tCO2-eq]`))

# value 3: most commonly counted gasses
gas_occurances <- dataset %>%
  count(`Gases included (CDP)`) %>%
  arrange(desc(n))

# value 4: average emissions for all groups of included gases
gas_avg <- dataset %>%
  group_by(`Gases included (CDP)`) %>%
  summarise(`Average emissions (CDP) [tCO2-wq]` = mean(`Total emissions (CDP) [tCO2-eq]`, na.rm = TRUE)) %>%
  arrange(desc(`Average emissions (CDP) [tCO2-wq]`))

# value 5: highest emissions / population ratio
high_ratio <- dataset %>%
  arrange(`Total emissions (CDP) [tCO2-eq]` / `Population (CDP)`) %>%
  mutate(`Location` = paste(`City name`, ", ", `Country`, sep = "")) %>%
  select(Location) %>%
  tail(1) %>%
  pull()