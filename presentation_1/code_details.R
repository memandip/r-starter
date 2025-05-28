# Detailed R Implementation for Car Fuel Efficiency Analysis
# This file contains detailed code implementations with explanations

# ---- 1. Initial Setup and Data Loading ----
library(datasets)  # For mtcars dataset
library(corrplot)  # For correlation visualization
library(glmnet)   # For LASSO regression
library(car)      # For VIF analysis
library(caret)    # For model training and evaluation

# Set random seed for reproducibility
set.seed(17)

# ---- 2. Data Preparation ----
# Create training and testing sets
train_index <- sample(2, nrow(mtcars), replace = TRUE, prob = c(0.7, 0.3))
train_data <- mtcars[train_index==1, ]
test_data <- mtcars[train_index==2, ]

# Data exploration
summary(train_data)  # Basic statistics
correlation_matrix <- cor(mtcars)
corrplot(correlation_matrix, method = "color", type = "upper",
         addCoef.col = "black", tl.col = "black", tl.srt = 45,
         title = "Correlation Matrix of Variables")

# ---- 3. Individual Variable Analysis ----
# Function to analyze individual predictors
analyze_predictor <- function(predictor_name, data) {
    # Fit simple linear model
    formula <- as.formula(paste("mpg ~", predictor_name))
    model <- lm(formula, data = data)
    
    # Get model summary
    model_summary <- summary(model)
    
    # Check BLUE criteria
    results <- list(
        R_squared = model_summary$r.squared,
        F_pvalue = model_summary$fstatistic[1],
        coef_pvalue = model_summary$coefficients[2,4],
        is_BLUE = model_summary$r.squared > 0.5 && 
                  model_summary$coefficients[2,4] < 0.05
    )
    
    return(results)
}

# Apply analysis to each predictor
predictors <- setdiff(names(train_data), "mpg")
predictor_results <- lapply(predictors, analyze_predictor, data = train_data)
names(predictor_results) <- predictors

# ---- 4. LASSO Implementation ----
# Prepare matrices for LASSO
x_train <- as.matrix(train_data[, predictors])
y_train <- train_data$mpg

# Perform cross-validation to find optimal lambda
lasso_cv <- cv.glmnet(x_train, y_train, alpha = 1)

# Plot cross-validation results
plot(lasso_cv, main = "LASSO Cross-Validation")

# Get coefficients for optimal lambda
lasso_coef <- coef(lasso_cv, s = "lambda.min")
selected_features <- rownames(lasso_coef)[which(lasso_coef != 0)]

# ---- 5. Model Performance Evaluation ----
# Function to calculate performance metrics
calculate_metrics <- function(actual, predicted) {
    RMSE <- sqrt(mean((actual - predicted)^2))
    MAE <- mean(abs(actual - predicted))
    R2 <- 1 - sum((actual - predicted)^2) / sum((actual - mean(actual))^2)
    
    return(c(RMSE = RMSE, MAE = MAE, R2 = R2))
}

# Fit final model with selected features
final_formula <- as.formula(paste("mpg ~", paste(selected_features[-1], collapse = " + ")))
final_model <- lm(final_formula, data = train_data)

# Get predictions
train_pred <- predict(final_model, train_data)
test_pred <- predict(final_model, test_data)

# Calculate metrics
train_metrics <- calculate_metrics(train_data$mpg, train_pred)
test_metrics <- calculate_metrics(test_data$mpg, test_pred)

# ---- 6. Example Prediction ----
# Create new data for 6000 lbs car
new_car <- data.frame(
    wt = 6,
    hp = mean(train_data$hp),
    am = mean(train_data$am)
)

# Make prediction with confidence intervals
prediction <- predict(final_model, new_car, interval = "prediction")

# Print results with warning about extrapolation
cat("Predicted MPG:", round(prediction[1], 2), "\n")
cat("95% Prediction Interval:", round(prediction[2], 2), "to", round(prediction[3], 2), "\n")
cat("WARNING: This prediction involves extrapolation beyond the training data range.\n")

# ---- Notes and Comments ----
# 1. Always check package dependencies before running
# 2. Verify data quality and missing values
# 3. Consider transformations if assumptions are violated
# 4. Be cautious with predictions outside data range
# 5. Document any modifications to the original dataset
