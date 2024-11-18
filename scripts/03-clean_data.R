#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
install.packages("haven")    
install.packages("dplyr")    
install.packages("ggplot2")  
install.packages("arrow")
library(haven)
library(dplyr)
library(ggplot2)
library(arrow)

nigeriasurvey <- read_sav("~/Downloads/nigeriasurvey.sav")

# Save the raw data as a Parquet file 
write_parquet(nigeriasurvey, "data/01-raw_data/nigeriasurvey.parquet")

# Reload the saved Parquet file to ensure it works
nigeriasurvey <- read_parquet("data/01-raw_data/nigeriasurvey.parquet")


# Select and clean relevant variables
key_vars <- c("Q38A", "Q94", "Q101", "Q1", "URBRUR", "REGION")  # Include relevant columns
cleaned_data <- nigeriasurvey %>%
  select(all_of(key_vars)) %>%
  filter(complete.cases(.))  # Remove rows with missing values in selected columns

# Recode Corruption Perception (Q38A)
cleaned_data$corruption_presidency <- factor(cleaned_data$Q38A, 
                                             levels = c(0, 1, 2, 3), 
                                             labels = c("None", "Some", "Most", "All"),
                                             ordered = TRUE)

# Handle special codes for Corruption (-1, 8, 9)
cleaned_data$corruption_presidency[cleaned_data$Q38A %in% c(-1, 8, 9)] <- NA

# Recode Education (from Q94)
cleaned_data$education <- factor(cleaned_data$Q94, 
                                 levels = c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9), 
                                 labels = c(
                                   "No formal schooling",
                                   "Informal schooling only",
                                   "Some primary schooling",
                                   "Primary school completed",
                                   "Some secondary schooling",
                                   "Secondary school completed",
                                   "Post-secondary qualifications",
                                   "Some university",
                                   "University completed",
                                   "Post-graduate"
                                 ))
cleaned_data$education[cleaned_data$Q94 %in% c(-1, 98, 99)] <- NA

# Recode Gender (from Q101)
cleaned_data$gender <- factor(cleaned_data$Q101, 
                              levels = c(1, 2), 
                              labels = c("Male", "Female"))

# Recode Age Group (from Q1, which is actually Age)
cleaned_data$age_group <- cut(cleaned_data$Q1, 
                              breaks = c(18, 24, 34, 44, 54, 100), 
                              labels = c("18-24", "25-34", "35-44", "45-54", "55+"), 
                              right = FALSE)

# Recode Urban/Rural Residence (from URBRUR)
cleaned_data$urban_rural <- factor(cleaned_data$URBRUR, 
                                   levels = c(1, 2), 
                                   labels = c("Urban", "Rural"))

# Recode Region (from REGION) as a Factor
cleaned_data$region <- as.factor(cleaned_data$REGION)

# Handle Missing Values
cleaned_data <- cleaned_data %>%
  filter(!is.na(corruption_presidency), !is.na(education), !is.na(gender), !is.na(age_group))

# Verify the cleaned data
str(cleaned_data)
summary(cleaned_data)

#### Save  cleaned data ####
write_parquet(cleaned_data, "data/02-analysis_data/cleaned_nigeriasurvey.parquet")
write.csv(cleaned_data, "data/02-analysis_data/cleaned_nigeriasurvey.csv", row.names = FALSE)



