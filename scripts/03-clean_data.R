#### Preamble ####
# Purpose: Cleans the survey data recorded by afrobarometer in Nigeria 
# Author: Fatimah Yunusa
# Date: 21 November 2024 
# Contact: fatimah.yunusa@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# Any other information needed? 

#### Workspace setup ####

library(haven)
library(dplyr)
library(ggplot2)
library(arrow)


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

cleaned_data <- cleaned_data %>%
  mutate(
    URBRUR = case_when(
      URBRUR == 1 ~ "Urban Residents",
      URBRUR == 2 ~ "Rural Residents",
      TRUE ~ NA_character_ # Assign NA for unexpected values
    )
  )
cleaned_data <- cleaned_data %>%
  mutate(
    urban_rural = case_when(
      urban_rural == "Urban" ~ "Urban Residents",
      urban_rural == "Rural" ~ "Rural Residents",
      TRUE ~ NA_character_ # Assign NA for unexpected values
    )
  )

cleaned_data <- cleaned_data %>%
  mutate(
    corruption_presidency = case_when(
      corruption_presidency == "None" ~ "No Corruption",
      corruption_presidency == "Some" ~ "Some Corruption",
      corruption_presidency == "Most" ~ "High Corruption",
      corruption_presidency == "All" ~ "All Corrupt",
      TRUE ~ NA_character_ # Assign NA for unexpected values
    )
  )

#### Save  cleaned data ####
write_parquet(cleaned_data, "data/02-analysis_data/cleaned_nigeriasurvey.parquet")
write.csv(cleaned_data, "data/02-analysis_data/cleaned_nigeriasurvey.csv", row.names = FALSE)


