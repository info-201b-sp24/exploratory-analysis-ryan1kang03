## Top 7 Countries and Emissions

# Load libraries
library(dplyr)
library(readxl)
library(ggplot2)

# Load the data using the absolute path
file_path <- "C:/Users/ryan1/OneDrive/Desktop/INFO201/exploratory-analysis-ryan1kang03/SCRIPTS/DATA/D_FINAL.xlsx"
emissions_data <- read_excel(file_path, sheet = 1)

# Select relevant columns
emissions_data <- emissions_data %>% 
  select(`Scope-1 GHG emissions [tCO2 or tCO2-eq]`, `Total emissions (CDP) [tCO2-eq]`, Country)

# Rename columns for convenience
colnames(emissions_data) <- c("Scope1_Emissions", "Total_Emissions_CDP", "Country")

# Sort the data by Total Emissions (CDP) column in descending order
sorted_data <- emissions_data %>% arrange(desc(Total_Emissions_CDP))

# Select the top 10 countries
top_7_countries <- head(sorted_data, 10)

# Print the data to verify
print(top_7_countries)

# Create the bar chart
chart 1 <- ggplot(top_7_countries, aes(x = reorder(Country, -Total_Emissions_CDP), y = Total_Emissions_CDP, fill = Country)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("darkseagreen2", "darkseagreen", "darkolivegreen", "darkgreen", "black", 
                               "darkseagreen2", "darkseagreen", "darkolivegreen", "darkgreen", "black")) +
  labs(x = "Country", y = "Total Emissions (CDP) [tCO2-eq]", title = "Top 7 Countries with Highest CO2 Emissions (CDP)") +
  theme_minimal()
