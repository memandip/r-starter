# Column Vector
# x <- c(1:30)
# y <- x^3
# plot(x,y)

initial.dir <- getwd()
setwd('~/Desktop/projects/r-starter/')
library(magrittr) # for pipes
# set the output file(it will bypass R and R Studio)
sink("session3.out")
# install.packages(dataset)
# save(dataset::iris, file = "iris.csv")
# iris <- datasets::iris
# write.csv(iris, "iris.csv")
iris <- read.csv("iris.csv", header = True)
plot(iris)
summary(iris)
cols <- names(iris)
iris %>% cor(Sepal.Length, Sepal.Width) # %$% fix
# Close the output file
sink()

# unload libraries
detach("package:magrittr")
setwd(initial.dir)
