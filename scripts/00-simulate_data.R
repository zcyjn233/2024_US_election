#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
  #state and party that won each division.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(853)


#### Simulate data ####
# Load necessary library
library(dplyr)

# Read the dataset
analysis_data <- read_parquet("/Users/lucky/Desktop/paper-2/data/02-analysis_data/DT.parquet")

# Inspect the structure of the 'pct' column to get a sense of the distribution
summary(data$pct)

# Set parameters for the distribution, using mean and standard deviation from actual data
mean_pct <- mean(data$pct, na.rm = TRUE)
sd_pct <- sd(data$pct, na.rm = TRUE)

# Simulate new candidate percentages based on a normal distribution
# Setting limits to keep values between 0 and 100 to ensure valid percentages
data$simulated_pct <- pmax(pmin(rnorm(n = nrow(data), mean = mean_pct, sd = sd_pct), 100), 0)

# View a summary of the simulated percentages
summary(data$simulated_pct)



#### Save data ####
write_csv(analysis_data, "/Users/lucky/Desktop/paper-2/data/00-simulated_data/simulated_data.csv")
