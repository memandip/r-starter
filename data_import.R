# by default the r-studio will set working directory as the root folder
# /home for mac
# setting current project as working directory
setwd("~/Desktop/projects/r-starter")
# if working directory is not set to current project, we will have to
# give full file path to read the file even if file exists in same location
# df = read.csv("/Users/admin/Desktop/projects/r-starter/covnep_252days.csv")
df = read.csv("covnep_252days.csv")
df
length(df$totalCases)
class(df$totalCases)
summary(df)


# choose from gui
# df = read.csv(file.choose())
# df
# summary(df)


plot(df$totalCases, df$totalRecoveries,
     panel.first = grid(8, 8),
     pch = 0, cex = 1.2, col = "black")
plot