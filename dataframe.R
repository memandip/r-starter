# DataFrames in R

df1 <- data.frame(
  programming_language = c("C", "C++", "Python", "Javascript"),
  ide = c("CLion", "Rider", "pycharm", "webstorm"),
  age = c(50, 40, 30, 20)
)

df2 <- data.frame(
  programming_language = c("Rust", "PHP", "Go", "Ruby", "Java"),
  ide = c("RustRover", "PhpStorm", "Goland", "RubyMine", "IntellijIdea"),
  age = c(5, 10, 15, 20)
)

df3 <- data.frame(
  popularity = c(4,3,1,2),
  start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11")),
  stringsAsFactors = FALSE # parsing the columns of a data table that contain strings (words or characters) as “categorical variable” which are called factors with levels in R 
)

df1$ide # access property or field of dataframe, same as accessing data using . operator in JS

columns_combined = cbind(df1, df3)
columns_combined

# for R bind (Row bind) column names must match
rows_combined = rbind(df1, df2)
rows_combined

class(rows_combined)

# Get structure of dataframe
str(rows_combined)

# get summary of data
summary(rows_combined)


pl_popularity = data.frame(columns_combined$programming_language, columns_combined$popularity)
pl_popularity

pl_popularity[1:2,] # extract first two rows
pl_popularity[,1:1] # extract first two columns
pl_popularity[1,2] # extract first row second column

