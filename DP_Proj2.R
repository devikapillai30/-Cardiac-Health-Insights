#libraries
options(scipen = 999)

#Q.1
#c
#importing dataset 
df <- (heart)
head(df,10)

#1 (b)
#cleaning data
clean_data <- function(df) {
  # Check for NA values in the data frame
  any_missing <- any(is.na(df))
  if (any_missing) {
    # Print the summary of missing values per column
    missing_per_column <- colSums(is.na(df))
    # Drop rows with any NA values
    df <- df[complete.cases(df), ]
    print("Rows with missing values dropped.")
  } else {
    print("No missing values found.")
  }
  
  #remove restingbp and cholestrol values with 0 
  # Assuming df is your dataset
  df <- subset(df, RestingBP != 0 & Cholesterol != 0)

  
  library(dplyr)
  #Making Sex, ChestPainType, FastingBS, RestingECG, ExerciseAngina, ST_Slope, HeartDisease to factors
  columns_to_convert <- c("Sex", "ChestPainType", "FastingBS", "RestingECG", "ExerciseAngina", "ST_Slope", "HeartDisease")
  df <- df |>
    mutate_at(vars(columns_to_convert), factor)
  return(df)
  
}
df <- clean_data(df)
head(df,10)


#1(e)
#univariate statistics
#mode function
getMode <- function(x1) {
  datavalues <- unique(x1)
  datavalues[which.max(tabulate(match(x1,datavalues)))]
}
#tabulating numerical data summary 
generate_summary_stats <- function(df, columns) {
  stats <- data.frame(
    Statistics = c("Mean", "Median", "Mode", "Min", "Max", "Variance", "Standard Deviation", "0% Quantile", "25% Quantile", "50% Quantile", "75% Quantile", "100% Quantile", "IQR")
  )
  for (col in columns) {
    col_stats <- c(
      mean(df[[col]]),
      median(df[[col]]),
      getMode(df[[col]]),
      min(df[[col]]),
      max(df[[col]]),
      var(df[[col]]),
      sd(df[[col]]),
      quantile(df[[col]], prob = c(0, 0.25, 0.5, 0.75, 1)),
      IQR(df[[col]])
    )
    stats[[col]] <- col_stats
  }
  return(stats)
}

numerical_columns <- c("Age", "RestingBP", "Cholesterol")
summary_stats <- generate_summary_stats(df, numerical_columns)
print(summary_stats)


library(ggplot2)
# Function to create a bar plot for a categorical variable
create_bar_plot <- function(data, variable) {
  ggplot(data, aes(x = !!as.symbol(variable), fill = factor(HeartDisease))) +
    geom_bar(position = "dodge") +
    scale_fill_manual(values = c("0" = "green", "1" = "red")) +
    labs(title = paste("Distribution of Heart Disease for", variable),
         x = variable,
         y = "Count",
         fill = "Heart Disease") +
    theme_minimal()
}

# Create bar plots for each categorical variable
categorical_variables <- c("Sex", "ChestPainType", "FastingBS", "RestingECG", "ExerciseAngina", "ST_Slope")
for (variable in categorical_variables) {
  plot_object <- create_bar_plot(df, variable)
  print(plot_object)
}

# Function to create a histogram for a numerical variable
create_histogram <- function(data, variable) {
  ggplot(data, aes(x = !!as.symbol(variable), fill = factor(HeartDisease))) +
    geom_histogram(position = "dodge", bins = 20, alpha = 0.7) +
    scale_fill_manual(values = c("0" = "green", "1" = "red")) +
    labs(title = paste("Distribution of Heart Disease for", variable),
         x = variable,
         y = "Count",
         fill = "Heart Disease") +
    theme_minimal()
}

# Create histograms for each numerical variable
numerical_variables <- c("Age", "RestingBP", "Cholesterol", "MaxHR", "Oldpeak")
for (variable in numerical_variables) {
  plot_object <- create_histogram(df, variable)
  print(plot_object)
}

#part2
#2.
#(a)
#one sample hypothesis testing
t_test_onesample <- t.test(df$RestingBP, mu = 120, alternative = "two.sided")
print(t_test_onesample)

#(b)
#two sample hypothesis testing
df_1 <- df[df$HeartDisease == 1, ]
df_0 <- df[df$HeartDisease == 0, ]
t_test_twosamople <- t.test(df_1$Cholesterol, df_0$Cholesterol)
t_test_twosamople

# 2+ factor ANOVA
#(c), (d)
#using formula object
# Define the input variables
ivars2 <- c("ChestPainType * RestingECG * HeartDisease",
            "ChestPainType * RestingECG + FastingBS * HeartDisease",
            "ChestPainType * RestingECG + Sex * HeartDisease")

# Create an empty list to store aov objects
obj2 <- vector(mode = "list", length = length(ivars2))
count2 <- 1
# Loop through the input variables and create aov objects
for (i in ivars2) {
  form2 <- as.formula(paste("Age ~", i))
  obj2[[count2]] <- aov(form2, data = df)
  count2 <- count2 + 1
} 
# Print the summaries
for (i in 1:length(ivars2)) {
  cat("\nSummary for ivars2[", ivars2[i], "]:\n")
  print(summary(obj2[[i]]))
}

#(e)
#logistic regression
logit_model <- glm(HeartDisease ~ Age + RestingBP + Cholesterol + MaxHR + Oldpeak, 
                   family = "binomial", data = df)
summary(logit_model)
#postestimation estimate
#1
new_data1 <- data.frame(Age = 25, RestingBP = 140, Cholesterol = 150, MaxHR = 200, Oldpeak = 1.5)
predicted_prob1 <- predict.glm(logit_model, new_data1, type = "response")
predicted_prob1
#2
new_data2 <- data.frame(Age = 80, RestingBP = 100, Cholesterol = 450, MaxHR = 120, Oldpeak = 2)
predicted_prob2 <- predict.glm(logit_model, new_data2, type = "response")
predicted_prob2












