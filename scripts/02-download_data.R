#### Preamble ####
# Purpose: Downloads and saves the data from afrobarometer
# Author: Fatimah Yunusa
# Date: 17 November 2024
# Contact: fatimah.yunusa@mail.utotonto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
install.packages("arrow")
install.packages("tidyverse")
install.packages("haven")
library(arrow)
library(tidyverse)
library(haven)


# Import the .sav file
nigeriasurvey <- read_sav("~/Downloads/nigeriasurvey.sav")

# View the imported data (optional)
View(nigeriasurvey)

# Save the dataframe as a Parquet file
write_parquet(nigeriasurvey, "data/01-raw_data/nigeriasurvey.parquet")

# Verify the saved Parquet file
verified_data <- read_parquet("data/01-raw_data/nigeriasurvey.parquet")
print(head(verified_data))


