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


#### Modeling: Ordinal Logistic Regression ####

# Load necessary libraries
install.packages(c("MASS", "broom", "ggplot2"))
library(MASS)   # For ordinal regression
library(broom)  # For tidy model outputs
library(ggplot2)

# Load the cleaned dataset
#cleaned_data <- read_parquet("data/02-analysis_data/fully_cleaned_nigeriasurvey.parquet")

# Ensure variables are factors
cleaned_data <- cleaned_data %>%
  mutate(
    gender = as.factor(gender),
    urban_rural = as.factor(urban_rural),
    education = as.factor(education),
    age_group = as.factor(age_group),
    corruption_presidency = as.ordered(corruption_presidency)  # Ensure outcome is ordered
  )

# Fit the ordinal logistic regression model
model <- polr(
  corruption_presidency ~ education + gender + urban_rural + age_group, 
  data = cleaned_data, 
  method = "logistic"
)

# View model summary
summary(model)

# Tidy model output with coefficients and p-values
model_results <- tidy(model, conf.int = TRUE)
print(model_results)

# Save model results to a CSV file
write.csv(model_results, "models/model_results.csv", row.names = FALSE)

# Calculate odds ratios for easier interpretation
odds_ratios <- exp(coef(model))
print(odds_ratios)

# Save odds ratios to a CSV file
write.csv(odds_ratios, "models/odds_ratios.csv")

#### Model Diagnostics ####

# McFadden's pseudo-R²
install.packages("DescTools")
library(DescTools)
pseudo_r2 <- PseudoR2(model, which = "McFadden")
cat("McFadden's pseudo-R²:", pseudo_r2, "\n")

# Proportional odds assumption test
install.packages("VGAM")
library(VGAM)
po_test <- vglm(corruption_presidency ~ education + gender + urban_rural + age_group, 
                family = cumulative(parallel = TRUE), 
                data = cleaned_data)
summary(po_test)

#### Visualize Results ####

# Visualize predicted probabilities for education
install.packages("effects")
library(effects)
plot(allEffects(model), main = "Effects of Predictors on Corruption Perception")

# Plot odds ratios
odds_ratios_df <- data.frame(
  Predictor = names(odds_ratios),
  OddsRatio = odds_ratios
)

ggplot(odds_ratios_df, aes(x = reorder(Predictor, OddsRatio), y = OddsRatio)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Odds Ratios of Predictors",
    x = "Predictors",
    y = "Odds Ratio"
  )

# Save plot
ggsave("models/odds_ratios_plot.png", width = 8, height = 6)

#### Save the Model ####
saveRDS(model, "models/final_model.rds")


