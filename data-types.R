# DataTypes
# Strings
first_name <- "Mandip"
last_name <- "Chaudhary"
full_name <- paste(first_name, last_name)

print(paste(first_name, last_name))
print(first_name == last_name)

print(paste(toupper(first_name), tolower(last_name)))

# Formatting a string
# avaliable values for justify [l,r,c]
# l = left, r = right, c = center
formatted_name = format(full_name, width = 50, justify = "c")

print(formatted_name)

# Splitting string in R
splitted_name <- strsplit(full_name, " ")
class(splitted_name)

# Using substring to replace string values
typo_name = "Mandga"
substring(typo_name,5,6)<-'ip' # replace 5th and 6th chars with specified characters
typo_name
print(nchar(typo_name)) # get number of characters

# Vectors, 
# R Vectors
# A vector is the basic data structure in R that stores data of similar types. For example,
# Suppose we need to record the age of 5 employees.
# Instead of creating 5 separate variables, we can simply create a vector.

programming_languages <- c("Python", "R", "NodeJS")
programming_languages <- append(programming_languages, "JAVA")
programming_languages

programming_languages[1]
programming_languages[5] <- "PHP"
programming_languages

cat("Total Elements:", length(programming_languages))

# numeric vectors
numbers <- c(1,2,3,4,5)
numbers
total <- length(numbers)
total

for(x in numbers){
  print(x)
}

num2 <- 6:10
num2

nums_repeat = rep(numbers, times = 2) # repeat vectors two times
nums_repeat

# R Matrix
# A matrix is a two-dimensional data structure where data are arranged into rows and columns.
# vector - the data items of same type
# nrow - number of rows
# ncol - number of columns
# byrow (optional) - if TRUE, the matrix is filled row-wise. By default, the matrix is filled column-wise.
first_matrix = matrix(c(1,2,3,4,5,6), nrow=2, ncol=3, byrow = FALSE)
first_matrix



# The only difference between vectors, matrices, and arrays are

# Vectors are uni-dimensional arrays
# Matrices are two-dimensional arrays
# Arrays can have more than two dimensions

# Check if element exists in matrix
has_one_in_matrix = 1 %in% first_matrix
has_one_in_matrix

even_matrix = matrix(c(2,4,6,8,10, 12), nrow=2, ncol=3, byrow = TRUE)
even_matrix

odd_matrix = matrix(c(1,3,5,7,9,11), nrow=2, ncol=3, byrow = TRUE)
odd_matrix

odd_matrix[1,1]

# combine two matrices by row
combined_by_row = rbind(even_matrix, odd_matrix)
combined_by_row

# combine two matrices by column
combined_by_col = cbind(even_matrix, odd_matrix)
combined_by_col



# R List
# A List is a collection of similar or different types of data.
# In R, we use the list() function to create a list.
list1 = list("Name", "Age", "Mandip", "30")
list1

matrix1 = matrix(list1, nrow=2)
matrix1

matrix1[,] # same as matrix1 (get all values of matrix)
matrix1[1,] # access entire element of first row
matrix1[2,] # access entire element of first column

combined_by_row[c(1,2),] # access entire element of first and second row
combined_by_row[,c(1,2)] # access entire element of first and second column

# Check if element exists
has_name_data = "Name" %in% list1
has_name_data

# R Array
# An Array is a data structure which can store data of the same type in more than two dimensions.

# The only difference between vectors, matrices, and arrays are

# Vectors are uni-dimensional arrays
# Matrices are two-dimensional arrays
# Arrays can have more than two dimensions
# Before we learn about arrays, make sure you know about R matrix and R vector.

# array(vector, dim = c(nrow, ncol, nmat))
# Here,
# vector - the data items of same type
# nrow - number of rows
# ncol - number of columns
# nmat - the number of matrices of nrow * ncol dimension

row.names <- c("Row1", "Row2")
column.names <- c("Col1", "Col2", "Col3")
matrix.names <- c("Matrix1", "Matrix2", "Matrix3")

array1 <- array(1:18, dim = c(2,3,3), dimnames = list(row.names, column.names, matrix.names))
array1
