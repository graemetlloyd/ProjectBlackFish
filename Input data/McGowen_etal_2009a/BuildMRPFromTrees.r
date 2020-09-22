# Script to build an MRP matrix from 1000 sampled trees from reanalysing McGowen data set (the molecular constraint for the metatree)

# Read in trees:
one_thousand_trees <- ape::read.tree("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Input data/McGowen_etal_2009a/Trees/mcgowen_random_sample.trees")

# Make each tree into an MRP matrix:
MRP <- lapply(X = one_thousand_trees, FUN = function(x) metatree::Tree2MRP(Trees = x, AddAllZero = FALSE))

# COmbine just these matrices:
MRP <- do.call(what = cbind, args = lapply(X = MRP, FUN = function(x) x$matrix_1$matrix))

# Reformat as a cladistic matrix:
MRP <- Claddis::build_cladistic_matrix(MRP)

# Compactify matrix, storing frequencies as weights:
MRP <- Claddis::compactify_matrix(MRP)

# Rescale weights on 999 to 1000 scale:
MRP$matrix_1$character_weights <- round(999 + ((MRP$matrix_1$character_weights - 1) / diff(range(MRP$matrix_1$character_weights))), 2)

# Write data to file:
Claddis::write_nexus_matrix(cladistic_matrix = MRP, file_name = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Input data/McGowen_etal_2009a/MRP/McGowen_etal_2009amrp.nex")
