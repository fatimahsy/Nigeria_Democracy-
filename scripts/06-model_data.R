#### Preamble ####
# Purpose: Models relationship between corruption perceptions and demographics. 
# Author: Fatimah Yunusa
# Date: 21 November 2024 
# Contact: fatimah.yunusa@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
# Any other information needed? 


#### Workspace setup ####


### Model data ####

#### Save model ####
#saveRDS(
#  first_model,
#  file = "models/first_model.rds"
#)


# Load necessary libraries
install.packages("MASS")
install.packages("dplyr")
install.packages("modelsummary")
install.packges("rstanarm")
linrary(rstanarm)
library(MASS)
library(dplyr)
library(modelsummary)

# Read data 

cleaned_data <- read_parquet("data/02-analysis_data/cleaned_nigeriasurvey.parquet")
#### Model ####
cleaned_data$corruption_presidency <- factor(
  cleaned_data$corruption_presidency,
  levels = c("None", "Some", "Most", "All"),
  ordered = TRUE
)

# Verify the structure
str(cleaned_data)

# Fit Bayesian ordinal logistic regression
bayesian_model <- stan_polr(
  formula = corruption_presidency ~ education + gender + urban_rural + age_group,
  data = cleaned_data,
  prior = R2(0.2),  # Prior for R-squared
  prior_counts = dirichlet(alpha = 1),  # Dirichlet prior for ordinal response
  seed = 123  # For reproducibility
)


# Save the model
saveRDS(bayesian_model, file = "models/bayesian_model.rds")
