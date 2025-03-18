# Construct a 5 x 6 matrix
my_matrix <- matrix(1:30, nrow = 5, ncol = 6)

# Calculate the sum of each column
col_sums <- apply(my_matrix, 2, sum)

# Print the result
print(col_sums)

