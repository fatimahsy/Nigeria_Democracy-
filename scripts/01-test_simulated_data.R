#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Nigerian Surveys dataset.
# Author: Fatimah Yunusa
# Date: 26 September 2024
# Contact: fatimah.yunusa@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `Nigeria_Democracy` rproj


#### Workspace setup ####
library(testthat)
library(readr)
library(dplyr)
library(tidyverse)

simulated_afrobarometer <- read_csv("data/00-simulated_data/simulated_afrobarometer.csv")

# Test if the data was successfully loaded
try({
  simulated_afrobarometer <- read_csv("data/00-simulated_data/simulated_afrobarometer.csv")
  # Check if the dataset is loaded successfully
  if (exists("simulated_afrobarometer")) {
    message("Test Passed: The dataset was successfully loaded.")
  } else {
    stop("Test Failed: The dataset could not be loaded.")
  }
}, silent = FALSE)

#### Test data ####

test_that("Simulated Afrobarometer dataset passes all high-quality tests", {
  # 1. These are Structure Tests
  expect_equal(ncol(simulated_afrobarometer), 12) # Check correct number of columns
  expect_named(simulated_afrobarometer, c(
    "respondent_id", "age", "gender", "education", "income_level",
    "trust_in_gov", "corruption_perception", "corruption_experience",
    "ethnic_group", "region", "urban_rural", "media_access", "corruption_risk"
  )) # Check column names
  
  # 2. Tests to check the Data Type 
  expect_type(simulated_afrobarometer$respondent_id, "integer")
  expect_type(simulated_afrobarometer$age, "integer")
  expect_type(simulated_afrobarometer$trust_in_gov, "integer")
  expect_type(simulated_afrobarometer$corruption_perception, "integer")
  expect_type(simulated_afrobarometer$corruption_experience, "integer")
  expect_type(simulated_afrobarometer$media_access, "integer")
  
  # 3. Test to check for Missing Values 
  key_columns <- c("respondent_id", "age", "gender", "education", "income_level")
  for (col in key_columns) {
    expect_true(all(!is.na(simulated_afrobarometer[[col]])))
  }
  
  # 4. Tests to check Range 
  expect_true(all(simulated_afrobarometer$age >= 18 & simulated_afrobarometer$age <= 80))
  expect_true(all(simulated_afrobarometer$trust_in_gov >= 1 & simulated_afrobarometer$trust_in_gov <= 5))
  expect_true(all(simulated_afrobarometer$corruption_perception >= 1 & simulated_afrobarometer$corruption_perception <= 5))
  
  # 5. Tests to chech Category Validity 
  expect_setequal(unique(simulated_afrobarometer$gender), c("Male", "Female"))
  expect_setequal(unique(simulated_afrobarometer$education), c("None", "Primary", "Secondary", "Tertiary"))
  expect_setequal(unique(simulated_afrobarometer$income_level), c("Low", "Middle", "High"))
  expect_setequal(unique(simulated_afrobarometer$ethnic_group), c("Hausa", "Yoruba", "Igbo", "Other"))
  expect_setequal(unique(simulated_afrobarometer$region), c("North", "South", "East", "West"))
  expect_setequal(unique(simulated_afrobarometer$urban_rural), c("Urban", "Rural"))
  expect_setequal(unique(simulated_afrobarometer$corruption_risk), c("High", "Low"))
  
  # 6. Tests to check Unique Identifier
  expect_equal(n_distinct(simulated_afrobarometer$respondent_id), nrow(simulated_afrobarometer))
})
