library(ggplot2)
library(dplyr)

temperature_data <- read.csv("GlobalLandTemperaturesByCountry.csv")

country <- "France"
country_data <- temperature_data %>%
  filter(Country == country) %>%
  na.omit() %>%
  mutate(dt = as.Date(dt))

yearly_avg_temp <- country_data %>%
  mutate(Year = format(dt, "%Y")) %>%
  group_by(Year) %>%
  summarize(AverageTemperature = mean(AverageTemperature))

yearly_avg_temp$Year <- as.numeric(yearly_avg_temp$Year)

plot <- ggplot(yearly_avg_temp, aes(x = Year, y = AverageTemperature)) +
  geom_line(color = "blue") +
  labs(title = paste("Average Yearly Temperature in", country),
       x = "Year",
       y = "Average Temperature (°C)") +
  theme_minimal()

print(plot)