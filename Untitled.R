setwd('~/Desktop/projects/r-starter')
library(magrittr)
set.seed(123) # It makes sure that each time random
# load 200 random variables which are normally distributed
rnorm(200) %>% matrix(ncol=2) %>% plot %>% colSums()

# "tee" pipe operator "%T>%", it makes sure that pipe operator runs after plot as well
rnorm(200) %>% matrix(ncol=2) %T>% plot %>% colSums()