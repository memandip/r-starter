gender <- factor(c("male", "female", "male", "female"))
typeof(gender)
attributes(gender)
unclass(gender)
gender2 <- ifelse(gender >= 2, 0, 1)
gender2
unclass(gender2)

date1 <- as.Date("2024-11-11")

"data" > "stat"
# R follows PEMDAS RULE
# Parentheses, Exponents, Multiplication, Division, Addition and Subtraction

x <- 1:10
z <- c(1,2)
x+z

x <- 1:10
w <- c(1,2,3)
x+w

x[1] # first value
x[1,2] # error
x[c(1,4)] # get specified elements

zchar <- c("Hokey", NA, "Cricket")
nchar(zchar)

z <- c(1,2,NA, 8,3,NA,3)

mean(z)
is.na(z)

mean(z, na.rm=TRUE)
var(z, na.rm=TRUE)
sd(z, na.rm=TRUE)


z1 <- ifelse(is.na(z), mean(z, na.rm=TRUE), z)
z1

some_list <- list("Mandip", 30, "Imadol")
names(some_list) <- c("Name", "Age", "Address")
some_list

names(some_list) <- c("Name1", "Age1", "Address1")
some_list

some_list2 <- unlist(some_list)
some_list2

nested_list <- list(c(1,2,3), c(4,5,6), c(7,8,9))
nested_list

flattened_list <- unlist(nested_list)
flattened_list

class(flattened_list)

flattened_list

new <- c(flattened_list, nested_list)
new
class(new)

my_list <- list(name="Mandip", age=25, address=c("Bardiya", "Lalitpur"), TRUE)
str(my_list)
str(new)


my_list <- list(
  person=c("John", "Jane", "Olivia", "Thomas", "Ram", "Shyam", "Hari"),
  age=c(20, 15, 30, 25, 26, 28, 27)
)

# create a factor
students_gender <- factor(c("male", "female", "male", "transgender", "female"))

# print the marital_status factor
print(students_gender)


