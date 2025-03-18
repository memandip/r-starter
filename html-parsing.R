install.packages("rvest")
library(rvest)

simple <- read_html("https://dataquestio.github.io/web-scraping-pages/simple.html")

simple %>% html_nodes("p") %>% html_text()

table <- read_html("https://w3schools.com/html/html_tables.asp")

table_heads <- table %>% html_nodes("table th") %>% html_text()

table_data <- table %>% html_nodes("table td") %>% html_text()
table_data

table_parsed <- table %>% html_nodes("table") %>% html_text()

table_df <- as.data.frame(table_data)

table_df
