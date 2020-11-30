# SCRIPT TO TEST RANDOM WEIGHTINGS FOR METATREE INFERENCE

# Read in safe STR version:
safe_str_nexus <- Claddis::read_nexus_matrix("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/Safe/STR.nex")

# Set number of replicates at 10:
NReplicates <- 10

# For each replicate:
for(i in 1:NReplicates) {
  
  # Use safe STR version as base:
  random_nexus <- safe_str_nexus
  
  # Shuffle character weights:
  random_nexus$matrix_1$character_weights <- sample(safe_str_nexus$matrix_1$character_weights)
  
  # rite out as TNT file:
  Claddis::write_tnt_matrix(random_nexus, paste0("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/RandomWeighting/STR_", i, ".tnt"))
  
  # Read TNT file in as raw text:
  random_nexus <- readLines(paste0("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/RandomWeighting/STR_", i, ".tnt"))
  
  # Add in custom analysis block:
  random_nexus <- gsub("proc/;", paste0("rseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch", i, ".tre;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch", i, ".tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch", i, ".tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch", i, ".tre +;\nsave;\ntsave /;\nrseed*;\nhold 10;\nxmult=rss fuse 10 drift 10 ratchet 10;\ntsave scratch", i, ".tre +;\nsave;\ntsave /;\nhold 1000;\nshortread scratch", i, ".tre;\nbbreak=tbr;\nexport -RandomWeightingSTRMPTs_", i, ".nex;\nproc/;"), random_nexus)
  
  # Write TNT out again with analysis block now added:
  write(random_nexus, paste0("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Metatree data/RandomWeighting/STR_", i, ".tnt"))

  
}
