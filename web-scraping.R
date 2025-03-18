# install.packages('jsonlite')
library(jsonlite)

Raw <- fromJSON("https://data.ny.gov/api/views/9a8c-vfzj/rows.json?accessType=DOWNLOAD")

food_market <- Raw[['data']]

str(food_market)

head(food_market)

Names <- food_market[,14]

head(Names)

table(Names)

table(V19)

table(food_market$V19)


table(food_market[,19])

head(table(food_market[,19]))


food_market.df <- as.data.frame(food_market)


summary(food_market.df)
