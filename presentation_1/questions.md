# Presentation 1: Supervised Learning

- Divide "mtcars" dataset as training data (70% random cases) and testing data (30% random cases) using "sample" in r
- Fit simple linear regression models on training data with mpg as dependent and all other variables as independent variables one by one i.e. separately. Are these models BLUE? Why?
- Identify the statistically significant (p<0.05) independent variables from simple linear regression models as potential candidate variables for the final model and list them for next step
- Fit a multiple linear regression model on training data with mpg as dependent and all the statistically significant variables from simple linear regression models
- Get VIF of all these variables to check multicollinearity and run the final model until none of the variables have VIF >= 10
- Get summary and accuracy indices (R-square, RMSE, MAE) of the final model fitted with variables having VIF < 10
- Use lasso regularization as alternative to deal with multicollinearity, show the results in the PPT and explain them well
- Perform residual analysis on the final model using LINE tests. Can you do prediction using this model? Why?
- Predict the mpg on testing data, get accuracy indices (R-square, RMSE, MAE) of prediction and interpret them carefully
- Prediction: How much mpg is given by a car with 6000 lbs weight based on training and testing data? Which is correct?
- Write a summary based on the results obtained above and include recommendations using data science approach.