setwd("~/Desktop/projects/r-starter")
library(rvest)
library(jsonlite)
library(tidyverse)

url <- "https://data.covid19india.org/"

covid_data <- read_html(url)

table_data <- covid_data %>% html_nodes("table") %>% html_table(fill = TRUE)

covid_19_deaths_ind_2024 <- table_data[[1]] %>% pivot_wider(names_from = X1, values_from = X2) # table data to key value pairs
write_json(covid_19_deaths_ind_2024, "covid_19_deaths_ind_2024.json")

# Set the first row as column names
colnames(table_data[[2]]) <- table_data[[2]][1, ]

# Remove the first row
covid_19_recovery_rate_ind_2024 <- table_data[[2]][-1, ]

json_data <- toJSON(covid_19_recovery_rate_ind_2024)
write_json(covid_19_recovery_rate_ind_2024, "covid_19_recovery_rate_ind_2024.json")