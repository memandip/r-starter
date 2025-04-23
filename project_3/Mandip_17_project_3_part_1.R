# Setup and libraries
library(ggplot2)
library(tidyverse)

# Load the airquality dataset
data(airquality)

# Basic summary of Temp and Wind variables
summary(airquality[c("Temp", "Wind")])

# Calculate median
median_temp = median(airquality$Temp, na.rm = TRUE)
temp_density <- density(airquality$Temp)

# Create histogram with density plot for Temperature
ggplot(airquality, aes(x = Temp)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "lightblue", color = "black") +
  geom_density(color = "red") +
  geom_vline(xintercept = median(airquality$Temp), color = "blue", linetype = "dashed") +
  annotate("text", x = median_temp, y = max(temp_density$y), 
           label = paste("Median =", round(median_temp, 1)), 
           vjust = -0.5, color = "red") +
  labs(title = "Temperature Distribution with Median",
       x = "Temperature (°F)",
       y = "Density") +
  theme_minimal()

# Create boxplot for Temperature
ggplot(airquality, aes(y = Temp)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Temperature Boxplot",
       y = "Temperature (°F)") +
  theme_minimal()

# Calculate median and mode
temp_median <- median(airquality$Temp)
density_temp <- density(airquality$Temp)
temp_mode <- density_temp$x[which.max(density_temp$y)]

# Print the calculated values
print(density_temp)
cat("\nTemperature Median:", temp_median, "°F\n")
cat("Temperature Mode (density peak):", round(temp_mode, 1), "°F\n")

# Remove NA values if any
airquality <- na.omit(airquality)

# Estimate the mode from density
temp_density <- density(airquality$Temp)
mode_temp <- temp_density$x[which.max(temp_density$y)]

# Plot density with mode line
ggplot(airquality, aes(x = Temp)) +
  geom_density(fill = "lightblue", color = "darkblue", alpha = 0.6) +
  geom_vline(aes(xintercept = mode_temp), color = "red", linetype = "dashed", size = 1) +
  annotate("text", x = mode_temp, y = max(temp_density$y), 
           label = paste("Mode =", round(mode_temp, 1)), 
           vjust = -0.5, color = "red") +
  labs(title = "Density Plot of Temperature (Temp)",
       x = "Temperature (F)",
       y = "Density") +
  theme_minimal()

# Create side-by-side histograms with density plots
par(mfrow = c(1, 2))

# Temperature distribution
hist(airquality$Temp, prob = TRUE, main = "Temperature Distribution",
     xlab = "Temperature (°F)", col = "lightblue", border = "black")
lines(density(airquality$Temp), col = "red")

# Wind distribution
hist(airquality$Wind, prob = TRUE, main = "Wind Distribution",
     xlab = "Wind Speed", col = "lightgreen", border = "black")
lines(density(airquality$Wind), col = "red")

# Reset plotting parameters
par(mfrow = c(1, 1))

# Perform Shapiro-Wilk test for normality
temp_shapiro <- shapiro.test(airquality$Temp)
wind_shapiro <- shapiro.test(airquality$Wind)

# Print test results
cat("\nShapiro-Wilk test for Temperature:\n")
print(temp_shapiro)
cat("\nShapiro-Wilk test for Wind:\n")
print(wind_shapiro)

# Calculate summary statistics for both variables
temp_summary <- c(
  mean = mean(airquality$Temp),
  sd = sd(airquality$Temp),
  median = median(airquality$Temp),
  IQR = IQR(airquality$Temp)
)

wind_summary <- c(
  mean = mean(airquality$Wind),
  sd = sd(airquality$Wind),
  median = median(airquality$Wind),
  IQR = IQR(airquality$Wind)
)

# Print summary statistics
cat("\nTemperature Summary Statistics:\n")
print(round(temp_summary, 2))
cat("\nWind Summary Statistics:\n")
print(round(wind_summary, 2))
