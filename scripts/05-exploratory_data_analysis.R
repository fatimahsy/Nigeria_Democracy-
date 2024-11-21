#### Preamble ####
# Purpose: Explores survey data from Afrobarometer 
# Author:Fatimah Yunusa
# Date: 21 November 2024 
# Contact: fatimah.yunusa@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
# Any other information needed? 


#### Workspace setup ####



#### Exploratory Data Analysis ####

# Load necessary libraries
install.packages(c("ggplot2", "dplyr"))
library(ggplot2)
library(dplyr)

# Load the cleaned dataset
cleaned_data <- read_parquet("data/02-analysis_data/fully_cleaned_nigeriasurvey.parquet")

# Summary statistics of the cleaned dataset
summary(cleaned_data)

# Check for missing values across key variables
sapply(cleaned_data, function(x) sum(is.na(x)))

# Distribution of the perception of corruption
ggplot(cleaned_data, aes(x = corruption_presidency)) +
  geom_bar(fill = "steelblue") +
  labs(title = "Distribution of Perception of Corruption in the Presidency",
       x = "Perceived Corruption Level",
       y = "Count")

# Distribution of education levels
ggplot(cleaned_data, aes(x = education)) +
  geom_bar(fill = "darkgreen") +
  labs(title = "Distribution of Education Levels",
       x = "Education Level",
       y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Corruption perception by education
ggplot(cleaned_data, aes(x = education, fill = corruption_presidency)) +
  geom_bar(position = "fill") +
  labs(title = "Perception of Corruption by Education Level",
       x = "Education Level",
       y = "Proportion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Corruption perception by gender
ggplot(cleaned_data, aes(x = gender, fill = corruption_presidency)) +
  geom_bar(position = "fill") +
  labs(title = "Perception of Corruption by Gender",
       x = "Gender",
       y = "Proportion")

# Corruption perception by urban/rural residence
ggplot(cleaned_data, aes(x = urban_rural, fill = corruption_presidency)) +
  geom_bar(position = "fill") +
  labs(title = "Perception of Corruption by Urban/Rural Residence",
       x = "Residence",
       y = "Proportion")

# Corruption perception by age group
ggplot(cleaned_data, aes(x = age_group, fill = corruption_presidency)) +
  geom_bar(position = "fill") +
  labs(title = "Perception of Corruption by Age Group",
       x = "Age Group",
       y = "Proportion")

# Cross-tabulation of gender and corruption perception
gender_correlation <- table(cleaned_data$gender, cleaned_data$corruption_presidency)
print(gender_correlation)

# Cross-tabulation of urban/rural and corruption perception
urban_rural_correlation <- table(cleaned_data$urban_rural, cleaned_data$corruption_presidency)
print(urban_rural_correlation)

# Cross-tabulation of education and corruption perception
education_correlation <- table(cleaned_data$education, cleaned_data$corruption_presidency)
print(education_correlation)

# Correlation between numeric variables (if any)
# Example: Correlation between age (numeric) and corruption perception (numeric encoding)
cor_age_corruption <- cor(cleaned_data$Q1, as.numeric(cleaned_data$corruption_presidency), use = "complete.obs")
cat("Correlation between Age and Perception of Corruption:", cor_age_corruption, "\n")

# Save the visualizations
#ggsave("outputs/eda/corruption_presidency_distribution.png", width = 8, height = 6)
#ggsave("outputs/eda/education_distribution.png", width = 8, height = 6)
#ggsave("outputs/eda/corruption_by_education.png", width = 8, height = 6)
#ggsave("outputs/eda/corruption_by_gender.png", width = 8, height = 6)
#ggsave("outputs/eda/corruption_by_urban_rural.png", width = 8, height = 6)
#ggsave("outputs/eda/corruption_by_age_group.png", width = 8, height = 6)

# End of EDA
