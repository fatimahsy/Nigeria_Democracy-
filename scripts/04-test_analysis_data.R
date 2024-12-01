#### Preamble ####
# Purpose: Tests created analysis survey data 
# Author: Fatimah Yunusa
# Date: 21 November 2024 
# Contact: fatimah.yunusa@mail.utoronto.ca 
# License: MIT
# Pre-requisites: read in `data/02-analysis_data/analysis_data.csv`
# Any other information needed? 


#### Workspace setup ####
if (!requireNamespace("testthat", quietly = TRUE)) install.packages("testthat")
if (!requireNamespace("validate", quietly = TRUE)) install.packages("validate")
if (!requireNamespace("pointblank", quietly = TRUE)) install.packages("pointblank")

library(testthat)
library(validate)
library(pointblank)
library(dplyr)


cleaned_data <- read_csv("data/02-analysis_data/cleaned_nigeriasurvey.csv")


#### Test data ####


### 1. TEST USING testthat
test_that("Cleaned dataset has correct structure and data types", {
  expect_true("corruption_presidency" %in% colnames(cleaned_data))
  expect_true("education" %in% colnames(cleaned_data))
  expect_true("gender" %in% colnames(cleaned_data))
  expect_true("age_group" %in% colnames(cleaned_data))
  expect_true("urban_rural" %in% colnames(cleaned_data))
  
  expect_s3_class(cleaned_data$corruption_presidency, "character")
  expect_s3_class(cleaned_data$education, "character")
  expect_s3_class(cleaned_data$gender, "character")
  expect_s3_class(cleaned_data$age_group, "character")
  expect_s3_class(cleaned_data$urban_rural, "character")
}) 

test_that("Cleaned dataset has no missing values in key columns", {
  expect_true(all(!is.na(cleaned_data$corruption_presidency)))
  expect_true(all(!is.na(cleaned_data$education)))
  expect_true(all(!is.na(cleaned_data$gender)))
})

test_that("No unexpected values in categorical variables", {
  expect_setequal(unique(cleaned_data$gender), c("Male", "Female"))
  expect_setequal(unique(cleaned_data$urban_rural), c("Urban Residents", "Rural Residents"))
})

### 2. TEST USING validate
validation_rules <- validator(
  corruption_presidency %in% c("None", "Some", "High", "All"),
  gender %in% c("Male", "Female"),
  age_group %in% c("18-24", "25-34", "35-44", "45-54", "55+"),
  urban_rural %in% c("Urban Residents", "Rural Residents"),
  is.character(education),
  !is.na(corruption_presidency),
  !is.na(education),
  !is.na(gender)
)

validation_results <- confront(cleaned_data, validation_rules)
summary(validation_results)
plot(validation_results)

### 3. TEST USING pointblank
agent <- create_agent(tbl = cleaned_data) %>%
  col_exists(columns = vars(corruption_presidency, education, gender, age_group, urban_rural)) %>%
  col_is_character(columns = vars(corruption_presidency, education, gender, age_group, urban_rural)) %>%
  col_vals_in_set(
    columns = vars(corruption_presidency), 
    set = c("None", "Some", "High", "All")
  ) %>%
  col_vals_in_set(
    columns = vars(gender),
    set = c("Male", "Female")
  ) %>%
  col_vals_in_set(
    columns = vars(urban_rural),
    set = c("Urban Residents", "Rural Residents")
  ) %>%
  col_vals_in_set(
    columns = vars(age_group),
    set = c("18-24", "25-34", "35-44", "45-54", "55+")
  ) %>%
  col_vals_not_null(columns = vars(corruption_presidency, education, gender)) %>%
  interrogate()

agent
