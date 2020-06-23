# SCRIPT TO GENERATE WORD FILE OF SOURCE REFERENCES

# Read in list of source files:
SourceFiles <- gsub(".xml", "", list.files(path = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Input data/XML"))

# Read in list of waiting room files:
WaitingRoomFiles <- gsub(".xml", "", list.files(path = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Input data/WaitingRoom/XML"))

# Read in mammals HTML:
MammalsHTML <- readLines("http://www.graemetlloyd.com/matrmamm.html")

# Get list of HTML formatted references:
HTMLFormattedRefs <- lapply(as.list(grep("<p class=\"hangingindent\">", MammalsHTML)), function(x) MammalsHTML[x:length(MammalsHTML)][1:grep("</p>", MammalsHTML[x:length(MammalsHTML)])[1]])

# Get just the source references and format as markdown:
MarkdownSourceRefs <- paste(unlist(lapply(as.list(SourceFiles), function(x) {HTMLRef <- HTMLFormattedRefs[[which(unlist(lapply(HTMLFormattedRefs, function(y) length(grep(x, y)))) == 1)]]; while(length(grep("  ", HTMLRef)) > 0) HTMLRef <- gsub("  ", " ", HTMLRef); HTMLRef <- paste(HTMLRef, collapse = ""); HTMLRef <- strsplit(HTMLRef, split = "<br>")[[1]][1]; HTMLRef <- gsub(" <p class=\"hangingindent\">", "", HTMLRef); HTMLRef <- gsub(", <b></b>, .", ".", HTMLRef); HTMLRef <- gsub("<b>|</b>", "**", HTMLRef); HTMLRef <- gsub("<em>|</em>", "*", HTMLRef); HTMLRef})), sep = "\n")

# Get just the waiting room references and format as markdown:
MarkdownWaitingRoomRefs <- paste(unlist(lapply(as.list(WaitingRoomFiles), function(x) {HTMLRef <- HTMLFormattedRefs[[which(unlist(lapply(HTMLFormattedRefs, function(y) length(grep(x, y)))) == 1)]]; while(length(grep("  ", HTMLRef)) > 0) HTMLRef <- gsub("  ", " ", HTMLRef); HTMLRef <- paste(HTMLRef, collapse = ""); HTMLRef <- strsplit(HTMLRef, split = "<br>")[[1]][1]; HTMLRef <- gsub(" <p class=\"hangingindent\">", "", HTMLRef); HTMLRef <- gsub(", <b></b>, .", ".", HTMLRef); HTMLRef <- gsub("<b>|</b>", "**", HTMLRef); HTMLRef <- gsub("<em>|</em>", "*", HTMLRef); HTMLRef})), sep = "\n")

# Write out markdown file:
write(paste("\\setlength{\\parindent}{-0.2in}", "\\setlength{\\leftskip}{0.2in}", "\\setlength{\\parskip}{8pt}", "\\noindent", "\n# References for included source data\n", paste(unique(MarkdownSourceRefs), collapse = "\n\n"), "\n# References for excluded source data (too recently discovered)\n", paste(unique(MarkdownWaitingRoomRefs), collapse = "\n\n"), sep = "\n"), file = "~/Dropbox/Mammal_Supertree/ProjectBlackFish/Input data/SourceList.md")

# Convert markdown file to MS Word:
setwd("~/Dropbox/Mammal_Supertree/ProjectBlackFish/Input data")
rmarkdown::pandoc_convert("SourceList.md", output = "SourceList.docx")
