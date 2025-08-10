library(dplyr)
# Loading dataset without converting strings to factors
adult_data <- read.csv("/Users/ayaanizhar/Stats Ass/adult.csv", 
                       header = TRUE, stringsAsFactors = FALSE)

# Looping through all the columns and printing the value counts 
# if column has character or factor values.
for (col_name in names(adult_data)) {
  if (is.character(adult_data[[col_name]]) || is.factor(adult_data[[col_name]])) {
    cat("\n--- Value Counts for:", col_name, "---\n")
    print(table(adult_data[[col_name]]))
  }
}

# Looping through all the columns and printing the value counts regardless of data type
for (col_name in names(adult_data)) {
  cat("\n--- Value Counts for:", col_name, "---\n")
  print(table(adult_data[[col_name]], useNA = "ifany"))
} 

# Loading dataset without converting strings to factors
adult_data <- read.csv("/Users/ayaanizhar/Stats Ass/adult.csv", header = TRUE, stringsAsFactors = FALSE,na.strings = c("?"))


# Summarising missing values per column using dplyr
adult_data %>%
  summarise_all(~ sum(is.na(.)))

# Total number of rows before cleaning
total_rows <- nrow(adult_data)

# Remove rows with missing values
adult_data_clean <- na.omit(adult_data)

# Number of rows after cleaning
cleaned_rows <- nrow(adult_data_clean)

# Rows removed
rows_removed <- total_rows - cleaned_rows

# Print results
cat("Original rows:", total_rows, "\n")
cat("Rows after removing NA:", cleaned_rows, "\n")
cat("Total rows removed:", rows_removed, "\n")

# Checking missing attributes count to handle each.
colSums(is.na(adult_data_clean))

# View structure before conversion
str(adult_data_clean)

# Convert categorical variables to factors
adult_data_clean$workclass       <- as.factor(adult_data_clean$workclass)
adult_data_clean$education       <- as.factor(adult_data_clean$education)
adult_data_clean$marital.status  <- as.factor(adult_data_clean$marital.status)
adult_data_clean$occupation      <- as.factor(adult_data_clean$occupation)
adult_data_clean$relationship    <- as.factor(adult_data_clean$relationship)
adult_data_clean$race            <- as.factor(adult_data_clean$race)
adult_data_clean$sex             <- as.factor(adult_data_clean$sex)
adult_data_clean$native.country  <- as.factor(adult_data_clean$native.country)
adult_data_clean$income          <- as.factor(adult_data_clean$income)

# checking structure after conversion
str(adult_data_clean)

# Generating boxplots for key numerical variables
boxplot(adult_data_clean$age,
        main = "Boxplot of Age",
        ylab = "Age",
        col = "lightblue")

boxplot(adult_data_clean$hours.per.week,
        main = "Boxplot of Hours Worked per Week",
        ylab = "Hours per Week",
        col = "lightgreen")

boxplot(adult_data_clean$capital.gain,
        main = "Boxplot of Capital Gain",
        ylab = "Capital Gain (USD)",
        col = "lightpink")

boxplot(adult_data_clean$capital.loss,
        main = "Boxplot of Capital Loss",
        ylab = "Capital Loss (USD)",
        col = "lightgray")

# Applying log transformation to reduce skewness
adult_data_clean$log_capital_gain <- log(adult_data_clean$capital.gain + 1)
adult_data_clean$log_capital_loss <- log(adult_data_clean$capital.loss + 1)



# Set up plotting area
par(mfrow = c(1, 2))

# Boxplot for capital gain after log transformation
boxplot(adult_data_clean$log_capital_gain,
        main = "Boxplot of Log Capital Gain",
        ylab = "Log(Capital Gain + 1)",
        col = "lightblue",
        border = "black")

# Boxplot for capital loss after log transformation
boxplot(adult_data_clean$log_capital_loss,
        main = "Boxplot of Log Capital Loss",
        ylab = "Log(Capital Loss + 1)",
        col = "lightgreen",
        border = "black")

# Summary of valid numerical variables (excluding discrete variables)
summary(adult_data_clean[, c("age", "hours.per.week", 
                             "log_capital_gain", "log_capital_loss")])

par(mfrow = c(2, 2))

hist(adult_data_clean$age,
     main = "Distribution of Age",
     xlab = "Age", col = "lightblue")

hist(adult_data_clean$hours.per.week,
     main = "Distribution of Weekly Work Hours",
     xlab = "Hours", col = "lightgreen")

hist(adult_data_clean$log_capital_gain,
     main = "Distribution of Log(Capital Gain)",
     xlab = "Log(Capital Gain + 1)", col = "lightpink")

hist(adult_data_clean$log_capital_loss,
     main = "Distribution of Log(Capital Loss)",
     xlab = "Log(Capital Loss + 1)", col = "lightgray")

cat_vars <- adult_data_clean[, sapply(adult_data_clean, is.factor)]

for (col in names(cat_vars)) {
  cat("Variable:", col, "\n")
  freq <- table(cat_vars[[col]])
  print(freq)
  
  prop <- round(prop.table(freq) * 100, 2)
  cat("Proportions (%):\n")
  print(prop)
  
  mode_value <- names(freq)[which.max(freq)]
  cat("Mode:", mode_value, "\n\n")
}



library(ggplot2)
library(gridExtra)

# Create individual plots
p1 <- ggplot(adult_data_clean, aes(x = education, fill = income)) +
  geom_bar(position = "dodge") +
  labs(title = "Education vs Income") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

p2 <- ggplot(adult_data_clean, aes(x = marital.status, fill = income)) +
  geom_bar(position = "dodge") +
  labs(title = "Marital Status vs Income") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

p3 <- ggplot(adult_data_clean, aes(x = occupation, fill = income)) +
  geom_bar(position = "dodge") +
  labs(title = "Occupation vs Income") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

p4 <- ggplot(adult_data_clean, aes(x = workclass, fill = income)) +
  geom_bar(position = "dodge") +
  labs(title = "Workclass vs Income") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

p5 <- ggplot(adult_data_clean, aes(x = sex, fill = income)) +
  geom_bar(position = "dodge") +
  labs(title = "Sex vs Income")

grid.arrange(p1,p2,p3,p4,p5,ncol = 2)

library(corrplot)
# T-test for age
t.test(age ~ income, data = adult_data_clean, var.equal = FALSE)

# T-test for hours worked per week
t.test(hours.per.week ~ income, data = adult_data_clean, var.equal = FALSE)


# Chi test for categorical
chisq.test(table(adult_data_clean$income, adult_data_clean$education))
chisq.test(table(adult_data_clean$income, adult_data_clean$marital.status))
chisq.test(table(adult_data_clean$income, adult_data_clean$occupation))
chisq.test(table(adult_data_clean$income, adult_data_clean$workclass))
chisq.test(table(adult_data_clean$income, adult_data_clean$sex))

# distribution of income class
ggplot(adult_data_clean, aes(x = income, fill = income)) +
  geom_bar() +
  labs(title = "Distribution of Income Classes", x = "Income", y = "Count") +
  theme_minimal()

# Create numeric target variable
adult_data_clean$income_num <- ifelse(adult_data_clean$income == ">50K", 1, 0)

# Logistic regression using glm
model_glm <- glm(income_num ~ age + hours.per.week +
                   education + marital.status + occupation +
                   workclass + sex,
                 data = adult_data_clean,
                 family = binomial)

# View model summary
summary(model_glm)


library(pROC)
library(caret)
library(e1071)

ll_null <- logLik(glm(income_num ~ 1, data = adult_data_clean, family = binomial))
ll_model <- logLik(model_glm)

pseudo_r2 <- 1 - as.numeric(ll_model / ll_null)
cat("McFadden's Pseudo R-squared:", round(pseudo_r2, 4))

dev.new()
# Predict probabilities from the logistic model
pred_probs <- predict(model_glm, type = "response")

# Generate ROC curve
roc_obj <- roc(adult_data_clean$income_num, pred_probs)

library(pROC)
# Plot ROC curve
plot(roc_obj, col = "blue", lwd = 2, main = "ROC Curve for Logistic Regression")
abline(a = 0, b = 1, lty = 2, col = "gray")  # Reference line

# AUC value
auc(roc_obj)

# Load required libraries
library(ggplot2)
library(reshape2)

# Construct the confusion matrix manually (as per your output)
conf_matrix <- matrix(c(20861, 3334,
                        1793, 4174),
                      nrow = 2, byrow = TRUE)

# Assign row and column names
rownames(conf_matrix) <- c("Predicted: <=50K", "Predicted: >50K")
colnames(conf_matrix) <- c("Actual: <=50K", "Actual: >50K")

# Convert to long format for ggplot
conf_df <- melt(conf_matrix)

# Plot heatmap
ggplot(conf_df, aes(x = Var2, y = Var1, fill = value)) +
  geom_tile(color = "white") +
  geom_text(aes(label = value), size = 6) +
  scale_fill_gradient(low = "lightblue", high = "steelblue") +
  labs(title = "Confusion Matrix (Threshold = 0.5)",
       x = "Actual", y = "Predicted") +
  theme_minimal(base_size = 14)


new_data <- data.frame(
  age = 40,
  hours.per.week = 45,
  education = factor("Prof-school", levels = levels(adult_data_clean$education)),
  marital.status = factor("Married-civ-spouse", levels = levels(adult_data_clean$marital.status)),
  occupation = factor("Exec-managerial", levels = levels(adult_data_clean$occupation)),
  workclass = factor("Private", levels = levels(adult_data_clean$workclass)),
  sex = factor("Male", levels = levels(adult_data_clean$sex))
)

# Predict the probability of earning >50K
predict(model_glm, newdata = new_data, type = "response")

# Exponentiate coefficients to get odds ratios
exp(coef(model_glm))
