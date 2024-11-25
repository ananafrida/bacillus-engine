library(ggtree)
library(ape)
library(treeio)
library(dplyr)
library(ggplot2)
library(tidytree)

offspring.tbl_tree_item <- utils::getFromNamespace(".offspring.tbl_tree_item", "tidytree")

######################################
################# ia #################
######################################
ia_tree <- read.nhx("C:/Users/anana/Documents/klebsiella-pneumoniae-engine/ecosim-with-gap/bootstrapped_ecotype.nhx")

x <- as_tibble(ia_tree)


ia_tree_graph <- ggtree(ia_tree)   +
 # geom_text(aes(label = proof), hjust = -0.5, size = 2) +
  geom_point2(aes(subset=(value>=0),
                  color = cut(value,
                              breaks = c(0, 35, 100))),
              size = 3, alpha = 0.9) +
  scale_color_manual(values=c("Yellow Green", "Firebrick"),
                     labels=c("0-35", "35-100")) +
  guides(alpha="none",
         size="none",
         color = guide_legend(title="Ecotype Bootstrap Score")) +
  theme(legend.position = c(0.05, 0.95), # Position legend in top-left corner
        legend.justification = c("left", "top")) + # Justify legend to the top-left corner
  # theme_tree2() +
 xlim(0.00, 0.04)


# Get the nodes with value > 35. This 35 value is determined using the
# commented out code below and the ecotype-distributions.py file's graph
nodes_to_label <- pull(filter(x, value > 35), node)

# Add cladelab for each node in the list with numbered labels
for (i in seq_along(nodes_to_label)) {
  ia_tree_graph <- ia_tree_graph + geom_cladelab(node = nodes_to_label[i], label = paste("Ecotype ", i), align = TRUE)
}

# # Use cowplot to adjust the width
# ia_tree_graph_wide <- plot_grid(ia_tree_graph, ncol = 1, rel_widths = c(100.5)) # Adjust rel_widths to stretch horizontally
# 

# Display the plot
print(ia_tree_graph)


# annotation
x <- as_tibble(ia_tree)
pull(filter(x, value > 35), node)


























# #code for showing the actual chances as the number in each node instead of color coding
# offspring.tbl_tree_item <- utils::getFromNamespace(".offspring.tbl_tree_item", "tidytree")
# 
# # Read the tree file
# ia_tree <- read.nhx("C:/Users/anana/Documents/klebsiella-pneumoniae-engine/ecosim-with-gap/bootstrapped_ecotype.nhx")
# 
# # Convert tree to tibble
# x <- as_tibble(ia_tree)
# 
# # Create the base ggtree plot
# ia_tree_graph <- ggtree(ia_tree) +
#   geom_point2(aes(subset=(value>=0),
#                   color = cut(value,
#                               breaks = c(0, 90, 100)),
#   ), size = 3, alpha = 0.9) +
#   scale_color_manual(
#     values=c("Yellow Green", "Firebrick"),
#     labels=c("0-90", "90-100")
#   ) +
#   guides(alpha="none",
#          size="none",
#          color = guide_legend(title="Ecotype Bootstrapped Score"))
# 
# # Extract tree data
# tree_data <- ia_tree_graph$data
# 
# # Calculate the maximum x coordinate (branch length) to use as a reference for offsets
# max_x <- max(tree_data$x)
# 
# # Define a function to calculate the offset based on the node depth
# calculate_offset <- function(node_depth, max_x, factor = 0.1) {
#   offset <- max_x - node_depth
#   return(offset * factor)
# }
# 
# # Finding all the nodes that need to be annotated
# x <- as_tibble(ia_tree)
# nodes <- filter(x, value > 0)
# 
# # Initialize the plot with the base tree
# plot <- ia_tree_graph
# 
# # Loop through the nodes and add geom_text layers with the values
# for (i in 1:nrow(nodes)) {
#   node <- nodes$node[i]
#   value <- nodes$value[i]
#   print(value * 5)
#   node_depth <- tree_data[tree_data$node == node, "x"]
#   offset <- calculate_offset(node_depth, max_x)
#   plot <- plot + geom_text2(aes(subset = (node == !!node), label = value * 5),
#                             hjust = -0.5,
#                             vjust = 0.3,
#                             size = 3,
#                             color = "black")
# }
# 
# # Add clade labels to demarcate ecotypes
# for (i in 1:nrow(nodes)) {
#   node <- nodes$node[i]
#   plot <- plot + geom_cladelab(node = node, label = paste("Eco", i), align = TRUE, offset = calculate_offset(node_depth, max_x))
# }
# 
# 
# # Display the plot
# print(plot)
