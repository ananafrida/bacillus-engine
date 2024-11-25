# Install and load necessary packages
install.packages("rlang")
install.packages("BiocManager")
library(BiocManager)
BiocManager::install("ggtree")

install.packages("tidyverse", dependencies = TRUE)
library(tidyverse)
library(ggtree)
library(ape)

# Read the Newick tree string into an R object
tree <- read.tree(text = "(Prokka_on_data_31__gff:0.0000004909,((((((((((((((Prokka_on_data_32__gff:0.0000004909,Prokka_on_data_33__gff:0.0000004909):0.0010205692,(Prokka_on_data_54__gff:0.0000004909,Prokka_on_data_55__gff:0.0000004909):0.0011009565):0.0137742938,NZ_CP034943.1:0.7353355225):0.0080787876,Prokka_on_data_56__gff:0.0020177309):0.0044373265,((((Prokka_on_data_39__gff:0.0000004909,Prokka_on_data_59__gff:0.0000004909):0.0000263124,Prokka_on_data_40__gff:0.0000380762):0.0019241675,Prokka_on_data_72__gff:0.0012362782):0.0071533487,Prokka_on_data_89__gff:0.0084028433):0.0050526292):0.0031425327,((Prokka_on_data_41__gff:0.0006151803,Prokka_on_data_44__gff:0.0000265226):0.0000004908,Prokka_on_data_43__gff:0.0000004909):0.0012996379):0.0007463758,(Prokka_on_data_80__gff:0.0001427439,((Prokka_on_data_81__gff:0.0000004909,Prokka_on_data_91__gff:0.0000004909):0.0000004908,Prokka_on_data_90__gff:0.0005267942):0.0000773215):0.0002388616):0.0001524947,(((Prokka_on_data_52__gff:0.0000004909,Prokka_on_data_76__gff:0.0000004909):0.0000128974,(Prokka_on_data_62__gff:0.0000004909,Prokka_on_data_63__gff:0.0000004909):0.0000004908):0.0000004908,Prokka_on_data_64__gff:0.0004295217):0.0001397754):0.0001767708,(((Prokka_on_data_42__gff:0.0000004909,Prokka_on_data_65__gff:0.0000004909):0.0000004908,Prokka_on_data_73__gff:0.0000004909):0.0002289384,Prokka_on_data_60__gff:0.0002145718):0.0001706528):0.0000219078,(Prokka_on_data_45__gff:0.0000004909,Prokka_on_data_46__gff:0.0000004909):0.0001142994):0.0001098607,Prokka_on_data_57__gff:0.0001870171):0.0003165194,(((Prokka_on_data_35__gff:0.0000004909,Prokka_on_data_36__gff:0.0000004909):0.0000004908,Prokka_on_data_84__gff:0.0005109482):0.0001298413,((Prokka_on_data_78__gff:0.0000004909,Prokka_on_data_83__gff:0.0000004909):0.0000004908,Prokka_on_data_79__gff:0.0000004909):0.0000386056):0.0000169040):0.0000519348,(Prokka_on_data_66__gff:0.0000004909,Prokka_on_data_67__gff:0.0000004909):0.0002127897):0.0000861788,Prokka_on_data_87__gff:0.0000722378):0.0000004908,Prokka_on_data_37__gff:0.0000004909);")

# Identify the outgroup taxon by name
outgroup_name <- "NZ_CP034943.1"

# Check if the outgroup is present in the tree
if (!outgroup_name %in% tree$tip.label) {
  stop("Outgroup taxon not found in the tree!")
}

# Root the tree using the outgroup
tree <- root(tree, outgroup = outgroup_name)
print(tree)


# or add the entire scale to the x axis with theme_tree2()
ggtree(tree) + theme_tree2()


# create the basic plot
p <- ggtree(tree, branch.length="none")

# Plot the tree with specified aesthetics
p +
  geom_nodepoint(color = "yellow", alpha = 0.5, size = 3) + # Large semi-transparent yellow node points
  ggtitle("Phylogenetic Tree") + # Add title
  theme_tree() # Ensure tree theme is applied


