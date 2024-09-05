# Heart Disease Analysis Project

<img src= "https://github.com/user-attachments/assets/e18724e1-4e66-4dfc-938a-7678b62a6e50" alt="Heart Disease Image" width="400"/>
## Introduction
This project aims to explore the intricate landscape of cardiovascular health by analyzing a comprehensive dataset on heart diseases, sourced from Kaggle. The dataset includes demographic factors and clinical measurements such as age, gender, chest pain type, blood pressure, cholesterol levels, and more. The objective is to understand the relationships between these variables and the presence or absence of heart disease, which can provide insights into cardiovascular health and help build predictive models.

<img src= "https://github.com/user-attachments/assets/d4d5754d-63c7-40e5-b8c6-e9282c2f4dc4" alt="Factors of Heart disease" width="400"/>

## Dataset Link: 
[Heart Disease Dataset on Kaggle](https://www.kaggle.com/datasets/amirmahdiabbootalebi/heart-disease/data)

## Data Preparation
1. **Data Cleaning:** A function was developed to check for missing values and drop rows with any null values, ensuring data quality.
2. **Outlier Removal:** Entries with unrealistic values in the Resting Blood Pressure (RestingBP) and Cholesterol columns were identified and removed, reducing the dataset from 918 to 746 rows.
3. **Data Transformation:** Selected columns (Sex, ChestPainType, FastingBS, RestingECG, ExerciseAngina, ST_Slope, HeartDisease) were converted into factors to prepare the data for analysis.

## Univariate Statistics
The dataset's numerical columns (Age, RestingBP, Cholesterol) were summarized using statistical measures such as mean, median, mode, and variance. Key findings include:
- Average age is approximately 52.9 years.
- Average resting blood pressure is 133 mm Hg, within the normal range.
- Average cholesterol level is 244.6 mg/dL, which is relatively high.
  
## Data Visualization
- **Categorical Variables:** Bar plots were created to visualize the distribution of heart disease across different categorical variables (Sex, ChestPainType, FastingBS, RestingECG, ExerciseAngina, ST_Slope).
- **Numerical Variables:** Histograms were plotted for numerical variables (Age, RestingBP, Cholesterol, MaxHR, Oldpeak) to observe their distributions in relation to heart disease status.

## Hypothesis Testing
- **One-Sample Test:** Tested whether the mean resting blood pressure differs significantly from the population mean of 120 mm Hg. The test concluded that the mean resting blood pressure in the dataset is significantly different from 120 mm Hg.
- **Two-Sample Test:** Compared cholesterol levels between patients with and without heart disease. Results indicated a significant difference in cholesterol levels between the two groups.

## ANOVA
Performed ANOVA to test the significance of various factors and their interactions on the response variable, age:
- Significant effects were found for ChestPainType, RestingECG, and HeartDisease.
- Interactions among variables were explored, revealing some significant and marginally significant interactions.

## Logistic Regression
A logistic regression model was developed to predict heart disease using Age, RestingBP, Cholesterol, MaxHR, and Oldpeak as predictors. Key findings include:
- Positive coefficients for Age, RestingBP, and Cholesterol, indicating that higher values increase the likelihood of heart disease.
- A negative coefficient for MaxHR, suggesting higher heart rates may reduce the likelihood of heart disease.
- Predictions made on new data demonstrated the practical use of the model in assessing heart disease risk based on patient characteristics.

## Conclusion
This project provided a comprehensive analysis of cardiovascular health data, revealing key factors influencing heart disease risk. The logistic regression model underscored the importance of age, cholesterol levels, and blood pressure in predicting heart disease, with practical applications for healthcare and risk assessment.
