## Top 10 Countries and Emissions Bar Chart


# Load libraries
library(dplyr)
library(readxl)
library(ggplot2)


# Load the data
emissions_data <- read_excel("/Users/ryan1/INFO201/exploratory-analysis-ryan1kang03/SCRIPTS/DATA/D_FINAL.xlsx", sheet = 1)

# Select relevant columns
emissions_data <- emissions_data %>% 
  select(`Scope-1 GHG emissions [tCO2 or tCO2-eq]`, `Total emissions (CDP) [tCO2-eq]`, Country)

# Rename columns
colnames(emissions_data) <- c("Scope1_Emissions", "Total_Emissions_CDP", "Country")

# Sort data by Total Emissions (CDP) column in descending order
sorted_data <- emissions_data %>% arrange(desc(Total_Emissions_CDP))

# Select top 10 countries
top_10_countries <- head(sorted_data, 10)

# Create bar chart
ggplot(top_10_countries, aes(x = reorder(Country, -Total_Emissions_CDP), y = Total_Emissions_CDP, fill = Country)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("darkseagreen2", "darkseagreen", "darkolivegreen", "darkgreen", "black", 
                               "darkseagreen2", "darkseagreen", "darkolivegreen", "darkgreen", "black")) +
  labs(x = "Country", y = "Total Emissions (CDP) [tCO2-eq]", title = "Top 10 Countries with Highest CO2 Emissions (CDP)") +
  theme_minimal()
