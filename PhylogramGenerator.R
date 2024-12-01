# Install and load necessary packages
install.packages("rlang")
install.packages("BiocManager")
library(BiocManager)
BiocManager::install("ggtree")

install.packages("tidyverse", dependencies = TRUE)
library(tidyverse)
library(ggtree)
library(ape)

# Specify the path to the .newick file
file_path <- "/Users/anana/Documents/bacillus-engine/input.newick"  # Replace with your file path

# Specify the output file path
output_file <- "/Users/anana/Documents/bacillus-engine/output.newick"  # Replace with your desired output path

# Read the Newick tree from the file
tree <- read.tree(file = file_path)

# Identify the outgroup taxon by name
outgroup_name <- "Prokka_on_data_1278__gff"

# Check if the outgroup is present in the tree
if (!outgroup_name %in% tree$tip.label) {
  stop("Outgroup taxon not found in the tree!")
}

# Root the tree using the outgroup
tree <- root(tree, outgroup = outgroup_name)
print(tree)

# Write the tree to the output file
write.tree(tree, file = output_file)

# Print a confirmation message
cat("The tree has been saved to:", output_file, "\n")


# or add the entire scale to the x axis with theme_tree2()
ggtree(tree) + theme_tree2()


# create the basic plot
p <- ggtree(tree, branch.length="none")

# Plot the tree with specified aesthetics
p +
  geom_nodepoint(color = "yellow", alpha = 0.5, size = 3) + # Large semi-transparent yellow node points
  ggtitle("Phylogenetic Tree") + # Add title
  theme_tree() # Ensure tree theme is applied


