
# Purpose: Cleans the raw data
# Author: Wei Wang , Chiyue Zhuang
# Date: 4 November 2024
# Contact: won.wang@mail.utoronto.ca, chiyue.zhuang@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(janitor)
#### Clean data ####
data <- read_csv("/Users/lucky/Desktop/paper-2/data/01-raw_data/president_polls.csv") |>
  clean_names()

just_trump_high_quality <- data |>
  filter(
    candidate_name == "Donald Trump",
    numeric_grade >= 2.8 # Need to investigate this choice - come back and fix.
    # Also need to look at whether the pollster has multiple polls or just one or two - filter out later
  ) |>
  mutate(
    state = if_else(is.na(state), "National", state), # Hacky fix for national polls - come back and check
    end_date = mdy(end_date)
  ) |>
  filter(end_date >= as.Date("2024-07-02")) |> 
  mutate(
    num_trump = round((pct / 100) * sample_size, 0) # Need number not percent for some models
  )
#### Plot data ####
base_plot <- ggplot(just_trump_high_quality, aes(x = end_date, y = pct)) +
  theme_classic() +
  labs(y = "Trump percent", x = "Date")
# Plots poll estimates and overall smoothing
base_plot +
  geom_point() +
  geom_smooth()
# Color by pollster
# This gets messy - need to add a filter - see line 21
base_plot +
  geom_point(aes(color = pollster)) +
  geom_smooth() +
  theme(legend.position = "bottom")
# Facet by pollster
# Make the line 21 issue obvious
# Also - is there duplication???? Need to go back and check
base_plot +
  geom_point() +
  geom_smooth() +
  facet_wrap(vars(pollster))
# Color by pollscore
base_plot +
  geom_point(aes(color = factor(pollscore))) +
  geom_smooth() +
  theme(legend.position = "bottom")

#### Save data ####
write_parquet(x = just_trump_high_quality,
              sink = "/Users/lucky/Desktop/paper-2/data/02-analysis_data/DT.parquet")

# 读取Parquet文件
df <- read_parquet("/Users/lucky/Desktop/paper-2/data/02-analysis_data/DT.parquet")

# 保存为CSV文件
write.csv(df, "/Users/lucky/Desktop/paper-2/data/02-analysis_data/DT.csv", row.names = FALSE)

