# Purpose: Tests the simulate data
  #electoral divisions dataset.
# Author: Wei Wang , Chiyue Zhuang
# Date: 4 November 2024
# Contact: won.wang@mail.utoronto.ca, chiyue.zhuang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(readr)
library(dplyr)
# Load the dataset
dataset <- read_csv("/Users/lucky/Desktop/paper-2/data/00-simulated_data/simulated_data.csv")

##test 1
test_that("Dataset has the expected structure", {
  
  # 1. Check for expected columns
  expected_columns <- c("column1", "column2", "column3")  # Replace with actual column names
  actual_columns <- colnames(dataset)
  
  expect_setequal(actual_columns, expected_columns)
  
  # 2. Check data types for each column
  # Replace `numeric` and `character` with the expected types for each column
  expect_type(dataset$column1, "numeric")
  expect_type(dataset$column2, "character")
  expect_type(dataset$column3, "numeric")
  
  # 3. Check for missing values (optional)
  expect_true(all(!is.na(dataset)))
})

##test 2
test_that("Statistical summaries match expected ranges", {
  
  # 1. Check the mean of column1 is within an expected range
  column1_mean <- mean(dataset$column1, na.rm = TRUE)
  expect_gte(column1_mean, 10)  # Expected lower bound
  expect_lte(column1_mean, 20)  # Expected upper bound
  
  # 2. Check the median of column2 falls within an expected range
  column2_median <- median(dataset$column2, na.rm = TRUE)
  expect_gte(column2_median, 5)
  expect_lte(column2_median, 15)
  
  # 3. Validate that the max value of column3 does not exceed a threshold
  column3_max <- max(dataset$column3, na.rm = TRUE)
  expect_lte(column3_max, 100)
  
  # 4. Test that the standard deviation of column1 is within a reasonable range
  column1_sd <- sd(dataset$column1, na.rm = TRUE)
  expect_gte(column1_sd, 0)
  expect_lte(column1_sd, 10)
  
  # 5. Verify that the sum of column4 meets an expected value
  column4_sum <- sum(dataset$column4, na.rm = TRUE)
  expect_equal(column4_sum, 500, tolerance = 0.1)  # Adjust tolerance as needed
  
  # 6. Check that no negative values are present in a specific column
  expect_true(all(dataset$column1 >= 0))
})
