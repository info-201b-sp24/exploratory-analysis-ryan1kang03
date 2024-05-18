# libraries
library("readxl")
library("dplyr")
library("ggplot2")

# load file and get data for plot
# Gasoline price (GEA+) [USD/liter]
# Emissions per person (CDP) [tCo2-eq/Person] AS
# Total emissions (CDP) [tCO2-eq] / Population (CDP)
data <- read_excel("./D_FINAL.xlsx") %>%
  mutate(`Emissions per Person (CDP) [tCo2-eq]` = `Total emissions (CDP) [tCO2-eq]` / `Population (CDP)`) %>%
  select(`Gasoline price (GEA+) [USD/liter]`, `Emissions per Person (CDP) [tCo2-eq]`) %>%
  na.omit()

# plot data as scatter plot
chart3 <- ggplot(data, aes(x = `Gasoline price (GEA+) [USD/liter]`, y = `Emissions per Person (CDP) [tCo2-eq]`)) +
  geom_point(col = "darkseagreen") +
  stat_smooth(method = lm, se = FALSE, color = "black") +
  labs(title = "Gasoline Price Vs Emissions", x = "Gas Price (USD / Liter)", y = "Average Emissions per Person (tCO2-eq)")