# Install and load libraries
install.packages("ggplot2")
library(ggplot2)
library(dplyr)

# Function to read and process each sample file
read_and_process_sample <- function(file_path, sample_name) {
  data <- read.table(file_path, header = TRUE)
  colnames(data) <- c("chromosome", "position", "depth")
  data$sample <- sample_name
  return(data)
}

# List of sample files and names
sample_files <- c(
  "spina_13_output.txt",
  "spina_16_output.txt",
  "spina_17_output.txt",
  "spina_19_output.txt",
  
  "muscle_51_output.txt",
  "muscle_6_output.txt", 
  "muscle_41_output.txt", 
  "muscle_5_output.txt",
  "muscle_4_output.txt", 
  "muscle_61_output.txt"

)

sample_names <- c("old", "old", "old", "old", "new", "new", "new", "new", "new", "new")

# Read and process each sample
sample_data <- mapply(read_and_process_sample, file_path = sample_files, sample_name = sample_names, SIMPLIFY = FALSE)

# Combine the data
combined_data <- bind_rows(sample_data)

# Plot
ggplot(combined_data, aes(x = position, y = depth, color = chromosome)) +
  geom_line() +
  facet_grid(sample ~ ., scales = "free_y", labeller = label_bquote(rows = .(sample))) +
  labs(title = "Depth vs Position for Samples",
       x = "Position",
       y = "Depth",
       color = "Chromosome") +
  theme_minimal() +
  theme(strip.text.y = element_text(angle = 0)) 

# Visual assessment of normality
hist(combined_data$depth[combined_data$sample == "old"], main = "Histogram of Depth for Old Samples", xlab = "Depth", breaks = 50)
qqnorm(combined_data$depth[combined_data$sample == "old"])
qqline(combined_data$depth[combined_data$sample == "old"])
hist(combined_data$depth[combined_data$sample == "new"], main = "Histogram of Depth for New Samples", xlab = "Depth", breaks = 50)
qqnorm(combined_data$depth[combined_data$sample == "new"])
qqline(combined_data$depth[combined_data$sample == "new"])


levene_test <- car::leveneTest(depth ~ sample, data = combined_data)
print(levene_test)
# Perform Mann-Whitney U test
mann_whitney_result <- wilcox.test(depth ~ sample, data = combined_data)
print(mann_whitney_result)

