setwd("/home/fronchetti/Documentos/JBCS-2018") # Working directory
plots <- par(mfrow=c(3,2))

pulls_summary <- read.csv("Dataset/atom/merged_pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA, NA, NA))
internals <- subset(pulls_summary, user_type == "Internals")
externals <- subset(pulls_summary, user_type == "Externals")
mar.default <- c(6,7,3,1) + 0.1
par(mar = mar.default + c(0, 5, 0, 0)) 
boxplot(externals$number_of_additions, internals$number_of_additions, externals$number_of_deletions, internals$number_of_deletions, externals$number_of_files_changed, internals$number_of_files_changed, ylim=c(0, 400), xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=2, cex.axis = 1.5, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), at = c(1,2,4,5,7,8), col=(c("#E6E6E6", "#727272", "#E6E6E6", "#727272", "#E6E6E6", "#727272")))
mtext(expression(bold("Atom")), side=3, las=1, adj=0.5, cex=1.3, line = 1)
mtext("Additions", side=2, at=1.5, las=1, outer=FALSE, adj=1.2, cex=1.3)
mtext("Deletions", side=2, at=4.5, las=1, outer=FALSE, adj=1.2, cex=1.3)
mtext("Files Changed", side=2, at=7.5, las=1, outer=FALSE, adj=1.1, cex=1.3)

pulls_summary <- read.csv("Dataset/electron/merged_pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA, NA, NA))
internals <- subset(pulls_summary, user_type == "Internals")
externals <- subset(pulls_summary, user_type == "Externals")
mar.default <- c(6,7,3,1) + 0.1
par(mar = mar.default + c(0, 5, 0, 0)) 
boxplot(externals$number_of_additions, internals$number_of_additions, externals$number_of_deletions, internals$number_of_deletions, externals$number_of_files_changed, internals$number_of_files_changed, ylim=c(0, 400), xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=2, cex.axis = 1.5, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), at = c(1,2,4,5,7,8), col=(c("#E6E6E6", "#727272", "#E6E6E6", "#727272", "#E6E6E6", "#727272")))
mtext(expression(bold("Electron")), side=3, las=1, adj=0.5, cex=1.3, line = 1)
mtext("Additions", side=2, at=1.5, las=1, outer=FALSE, adj=1.2, cex=1.3)
mtext("Deletions", side=2, at=4.5, las=1, outer=FALSE, adj=1.2, cex=1.3)
mtext("Files Changed", side=2, at=7.5, las=1, outer=FALSE, adj=1.1, cex=1.3)

pulls_summary <- read.csv("Dataset/git-lfs/merged_pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA, NA, NA))
internals <- subset(pulls_summary, user_type == "Internals")
externals <- subset(pulls_summary, user_type == "Externals")
mar.default <- c(6,7,3,1) + 0.1
par(mar = mar.default + c(0, 5, 0, 0)) 
boxplot(externals$number_of_additions, internals$number_of_additions, externals$number_of_deletions, internals$number_of_deletions, externals$number_of_files_changed, internals$number_of_files_changed, ylim=c(0, 400), xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=2, cex.axis = 1.5, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), at = c(1,2,4,5,7,8), col=(c("#E6E6E6", "#727272", "#E6E6E6", "#727272", "#E6E6E6", "#727272")))
mtext(expression(bold("Git-lfs")), side=3, las=1, adj=0.5, cex=1.3, line = 1)
mtext("Additions", side=2, at=1.5, las=1, outer=FALSE, adj=1.2, cex=1.3)
mtext("Deletions", side=2, at=4.5, las=1, outer=FALSE, adj=1.2, cex=1.3)
mtext("Files Changed", side=2, at=7.5, las=1, outer=FALSE, adj=1.1, cex=1.3)

pulls_summary <- read.csv("Dataset/hubot/merged_pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA, NA, NA))
internals <- subset(pulls_summary, user_type == "Internals")
externals <- subset(pulls_summary, user_type == "Externals")
mar.default <- c(6,7,3,1) + 0.1
par(mar = mar.default + c(0, 5, 0, 0)) 
boxplot(externals$number_of_additions, internals$number_of_additions, externals$number_of_deletions, internals$number_of_deletions, externals$number_of_files_changed, internals$number_of_files_changed, ylim=c(0, 400), xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=2, cex.axis = 1.5, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), at = c(1,2,4,5,7,8), col=(c("#E6E6E6", "#727272", "#E6E6E6", "#727272", "#E6E6E6", "#727272")))
mtext(expression(bold("Hubot")), side=3, las=1, adj=0.5, cex=1.3, line = 1)
mtext("Additions", side=2, at=1.5, las=1, outer=FALSE, adj=1.2, cex=1.3)
mtext("Deletions", side=2, at=4.5, las=1, outer=FALSE, adj=1.2, cex=1.3)
mtext("Files Changed", side=2, at=7.5, las=1, outer=FALSE, adj=1.1, cex=1.3)

pulls_summary <- read.csv("Dataset/linguist/merged_pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA, NA, NA))
internals <- subset(pulls_summary, user_type == "Internals")
externals <- subset(pulls_summary, user_type == "Externals")
mar.default <- c(6,7,3,1) + 0.1
par(mar = mar.default + c(0, 5, 0, 0)) 
boxplot(externals$number_of_additions, internals$number_of_additions, externals$number_of_deletions, internals$number_of_deletions, externals$number_of_files_changed, internals$number_of_files_changed, ylim=c(0, 400), xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=2, cex.axis = 1.5, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), at = c(1,2,4,5,7,8), col=(c("#E6E6E6", "#727272", "#E6E6E6", "#727272", "#E6E6E6", "#727272")))
mtext(expression(bold("Linguist")), side=3, las=1, adj=0.5, cex=1.3, line = 1)
mtext("Additions", side=2, at=1.5, las=1, outer=FALSE, adj=1.2, cex=1.3)
mtext("Deletions", side=2, at=4.5, las=1, outer=FALSE, adj=1.2, cex=1.3)
mtext("Files Changed", side=2, at=7.5, las=1, outer=FALSE, adj=1.1, cex=1.3)

