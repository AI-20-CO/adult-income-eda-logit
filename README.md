# Adult Income Dataset Analysis

This project performs **Exploratory Data Analysis (EDA)**, **data cleaning**, **statistical hypothesis testing**, and **logistic regression modeling** on the Adult Income dataset to identify demographic and socioeconomic predictors of earning more than $50K annually.

## Dataset
The dataset is the **Adult Census Income** dataset from the UCI Machine Learning Repository. It contains demographic and income-related attributes for individuals.

## Script Features

### 1. **Data Loading & Cleaning**
- Reads CSV data without converting strings to factors.
- Handles missing values (`?` → NA) and removes incomplete rows.
- Converts categorical variables to factors.
- Provides summary statistics for numerical and categorical variables.

### 2. **Data Visualization**
- **Boxplots** for `age`, `hours-per-week`, `capital-gain`, and `capital-loss`.
- **Log transformations** to reduce skewness.
- **Histograms** for numeric features.
- **Bar plots** for categorical variables vs. income using `ggplot2`.

### 3. **Statistical Analysis**
- **T-tests** for numerical features against income.
- **Chi-square tests** for categorical variables against income.
- **Correlation analysis** for numeric features.

### 4. **Logistic Regression**
- Predicts income class (`>50K` vs `<=50K`) using demographic and work-related variables.
- Calculates **McFadden’s pseudo R²**.
- Generates **ROC curve** and computes **AUC**.
- Creates **confusion matrix heatmap**.

### 5. **Prediction Example**
- Uses a sample individual's profile to predict income probability.
- Calculates **odds ratios** for model interpretation.

The model achieved an accuracy of 83.54% with an AUC of 0.898, indicating strong classification performance.

The statistically significant socio-economic factors out of the 12 economic factors in the dataset associated with earning above 50K after our EDA are the following:

Age – Older individuals generally have a higher probability of earning above 50K.

Hours per Week – Working more hours per week is positively associated with higher income.

Education – Higher education levels (e.g., Bachelors, Masters, Professional school) significantly increase the likelihood of higher earnings.

Marital Status – Being married (especially "Married-civ-spouse") shows a strong positive correlation with income.

Occupation – Roles in executive, managerial, and professional fields are strongly linked to higher income levels.

Workclass – Certain work classes, particularly private sector and government jobs, have higher odds compared to others.

Sex – Being male is associated with a higher probability of earning above 50K in this dataset.



## Installation

Clone the repo  Install the required R packages:

```bash
git clone https://github.com/<your-username>/adult-income-eda-logit.git
cd adult-income-eda-logit

r

install.packages("renv")
renv::init()
renv::install(c(
  "dplyr",
  "ggplot2",
  "gridExtra",
  "corrplot",
  "pROC",
  "caret",
  "e1071",
  "reshape2"
))

source("run_all.R")
