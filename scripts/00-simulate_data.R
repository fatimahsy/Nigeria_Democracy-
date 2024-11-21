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
set.seed(853)


#### Simulate data ####

#### Save data ####
write_csv(analysis_data, "data/00-simulated_data/simulated_data.csv")
