library(rvest)
library(dbplyr)

url <- "https://en.wikipedia.org/wiki/COVID-19_pandemic_in_Nepal#Data"

covid_data <- read_html(url)

table_data <- covid_data %>% html_nodes(".COVID-19_pandemic_data_Nepal_medical_cases table") %>% html_table()

head(table_data)

table_df <- as.data.frame(table_data)
table_df
names(table_df)

table_df$Date

head(table_data)

names(table_df)

table.tibble <- tibble::as.tibble(table_df)
