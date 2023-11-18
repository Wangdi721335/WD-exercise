# Load necessary packages
if (!requireNamespace("here", quietly = TRUE)) install.packages("here")
if (!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")

# Load required packages
library(tidyverse)
library(here)

# Task 2: Read and Explore the Data
# Read the data from the specified URL with a tab separator and a header
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = TRUE)

# Explore the structure and dimensions of the data
str(learning2014) # Output the structure of the data
dim(learning2014) # Output the dimensions of the data

# Task 3: Create Analysis Dataset
# Define question categories
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06", "D15", "D23", "D31")
surface_questions <- c("SU02", "SU10", "SU18", "SU26", "SU05", "SU13", "SU21", "SU29", "SU08", "SU16", "SU24", "SU32")
strategic_questions <- c("ST01", "ST09", "ST17", "ST25", "ST04", "ST12", "ST20", "ST28")

# Create new columns for averaged values
learning2014 <- learning2014 %>%
  mutate(deep = rowMeans(select(., all_of(deep_questions))),
         surf = rowMeans(select(., all_of(surface_questions))),
         stra = rowMeans(select(., all_of(strategic_questions))))

# Select and filter desired variables
analysis_dataset <- learning2014 %>%
  select(gender, Age, Attitude, deep, stra, surf, Points) %>%
  filter(Points > 0)

# Task 4: Set Working Directory and Save Analysis Dataset
# Set working directory to E:/R课程/WD new/Data
setwd(here("E:/R课程/WD new/Data"))

# Save the analysis dataset to the 'data' folder as CSV
write_csv(analysis_dataset, file = here("data/learning2014.csv"))

# Demonstrate reading the data again
strl <- read_csv(here("data/learning2014.csv")) # Read the data using read_csv
headl <- head(read_csv(here("data/learning2014.csv"))) # Display the first few rows of the data