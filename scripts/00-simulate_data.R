#### Preamble ####
# Purpose: Simulates a survey dataset. 
# Author: Fatimah Yunusa 
# Date: 21 November 2024 
# Contact: fatimah.yunusa@mail.utoronto.ca 
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? 


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(readr)
set.seed(200)

#### Simulate data ####

# Number of respondents
n <- 1000

simulated_afrobarometer <- data.frame(
  respondent_id = 1:n,
  age = sample(18:80, n, replace = TRUE),
  gender = sample(c("Male", "Female"), n, replace = TRUE, prob = c(0.5, 0.5)),
  education = sample(c("None", "Primary", "Secondary", "Tertiary"), n, replace = TRUE, prob = c(0.2, 0.3, 0.3, 0.2)),
  income_level = sample(c("Low", "Middle", "High"), n, replace = TRUE, prob = c(0.5, 0.4, 0.1)),
  trust_in_gov = sample(1:5, n, replace = TRUE, prob = c(0.1, 0.2, 0.3, 0.25, 0.15)), # 1 = No Trust, 5 = High Trust
  corruption_perception = sample(1:5, n, replace = TRUE, prob = c(0.3, 0.3, 0.2, 0.15, 0.05)), # 1 = Very Corrupt, 5 = Not Corrupt
  corruption_experience = rbinom(n, 1, prob = 0.3), # 0 = No, 1 = Yes
  ethnic_group = sample(c("Hausa", "Yoruba", "Igbo", "Other"), n, replace = TRUE, prob = c(0.3, 0.3, 0.3, 0.1)),
  region = sample(c("North", "South", "East", "West"), n, replace = TRUE),
  urban_rural = sample(c("Urban", "Rural"), n, replace = TRUE, prob = c(0.6, 0.4)),
  media_access = sample(1:5, n, replace = TRUE, prob = c(0.1, 0.2, 0.4, 0.2, 0.1)) # 1 = Low Access, 5 = High Access
)

# Adding derived variable: Perceived corruption risk based on perception and experience
simulated_afrobarometer <-  simulated_afrobarometer %>%
  mutate(
    corruption_risk = ifelse(corruption_perception <= 2 | corruption_experience == 1, "High", "Low")
  )


#### Simulate data ####

#### Save data ####
write_csv(simulated_afrobarometer, "data/00-simulated_data/simulated_afrobarometer.csv")
