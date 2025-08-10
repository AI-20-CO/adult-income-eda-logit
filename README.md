# Adult Income Dataset Analysis

This project performs **Exploratory Data Analysis (EDA)**, **data cleaning**, **statistical hypothesis testing**, and **logistic regression modeling** on the Adult Income dataset to identify demographic and socioeconomic predictors of earning more than $50K annually.

## Dataset
The dataset is the [**Adult Census Income**](https://www.kaggle.com/datasets/uciml/adult-census-income) dataset from the UCI Machine Learning Repository. It contains demographic and income-related attributes for individuals.

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

### The model achieved an accuracy of 83.54% with an AUC of 0.898, indicating strong classification performance.

The statistically significant socio-economic factors out of the 12 economic factors in the dataset associated with earning above 50K after our EDA are the following:

| Factor             | Relationship with >50K Income                      | Reasoning                                                                                                              |
| ------------------ | -------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **Age**            | Positive (older → higher income)                   | Older individuals often have more experience, seniority, and career advancement, leading to higher pay.                |
| **Hours per Week** | Positive (more hours → higher income)              | Working longer hours may indicate full-time or high-demand roles, which often offer better pay.                        |
| **Education**      | Positive (higher education → higher income)        | Advanced degrees typically lead to specialized, higher-paying jobs.                                                    |
| **Marital Status** | Positive (married → higher income)                 | Married individuals, particularly in stable partnerships, may have more financial stability and career progression.    |
| **Occupation**     | Positive (professional/managerial → higher income) | Executive, managerial, and technical roles usually offer higher salaries due to responsibility and skill requirements. |
| **Workclass**      | Positive (private/government → higher income)      | Certain sectors offer more competitive pay and benefits compared to others.                                            |
| **Sex**            | Positive (male → higher income)                    | Reflects existing gender pay disparities in the dataset, not necessarily skill or qualification differences.           |



## Installation

1. Download the dataset from kaggle - [**Adult Census Income**](https://www.kaggle.com/datasets/uciml/adult-census-income)
3. Clone the repo & install the required R packages 

```bash
git clone https://github.com/<your-username>/adult-income-eda-logit.git
cd adult-income-eda-logit
```

```r terminal
install(c(
  "dplyr",
  "ggplot2",
  "gridExtra",
  "corrplot",
  "pROC",
  "caret",
  "e1071",
  "reshape2"
))
```

3. Make sure the dataset file is placed in the same directory as the adult-income-eda-logit project folder.
