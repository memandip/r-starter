# Load in the Iris data from internet:

iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), header = FALSE)

head(iris)

# Add column names for V1, V2, V3, V4 and V5 column to the Iris data

names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

print(names(iris))
