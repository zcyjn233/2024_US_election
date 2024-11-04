
# Purpose: First model
# Author: Wei Wang , Chiyue Zhuang
# Date: 4 November 2024
# Contact: won.wang@mail.utoronto.ca, chiyue.zhuang@mail.utoronto.ca


#### Workspace setup ####
library(plyr)
library(ggiraph)
library(ggiraphExtra)
library(tidyverse)
library(rstanarm)
library(ggplot2)
library(arrow)
library(broom)
#### Read data ####
data1 <- read_parquet("/Users/lucky/Desktop/paper-2/data/02-analysis_data/DT.parquet")

head(data1)
# Convert 'pollster' and 'state' to factors, and 'end_date' to Date format
data1$pollster <- as.factor(data1$pollster)
data1$state <- as.factor(data1$state)
data1$end_date <- as.Date(data1$end_date, format = "%Y-%m-%d") # Adjust the date format if necessary
data1$pollscore <- as.numeric(as.character(data1$pollscore))
data1$pct <- as.numeric(as.character(data1$pct))

# Handle any NA values by filling or removing as needed
# data1$pollscore[is.na(data1$pollscore)] <- mean(data1$pollscore, na.rm = TRUE)
# data1$pct[is.na(data1$pct)] <- mean(data1$pct, na.rm = TRUE)
# data1 <- na.omit(data1)
# Fit the linear model
str(data1)
View(data1)
str(data1[,c("pct","race_id","pollster")])
numeric_vars <- names(data1)[sapply(data1, is.numeric)]
print(numeric_vars)
paste0(numeric_vars,collapse ="+")
view(data1[,numeric_vars])
data1=data1[numeric_vars]
view(data1)
linear.model2 <- lm(pct ~ numeric_grade+pollscore+
                      transparency_score , data = data1)
# Display the summary and confidence intervals of the model
summary(linear.model2)
confint(linear.model2)
# Load ggiraphExtra for visualization
if (!require("ggiraphExtra")) install.packages("ggiraphExtra")
ggPredict(linear.model2, digits = 1, show.point = TRUE, se = TRUE, xpos = 0.5)

#### Save model ####
saveRDS(linear.model2,"/Users/lucky/Desktop/paper-2/models/linear.model2.rds")
