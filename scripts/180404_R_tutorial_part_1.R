# Last Updated: 180404
# Author: Wesley Cai
# Purpose: To demo a script for
#   R script tutorial part 1

# For mac
setwd("/folder_path")

# For PC
setwd("C:/folder_path")

# Load relevant packages
library(ComplexHeatmap)

# Read in data
myDF <- read.table("microarray_values.txt",
                   sep = "\t", 
                   row.names = 1, 
                   header = TRUE, 
                   check.names = FALSE)

# Transform data for heatmap
myMatrix <- as.matrix(myDF)
myScaledMatrix <- t(scale(t(myMatrix)))

# Plot Heatmap
Heatmap(myScaledMatrix)
