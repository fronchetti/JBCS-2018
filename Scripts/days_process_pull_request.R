# install.packages("reshape2")
# install.packages("scales")
library(scales)
library(reshape2)

# Image: 880 x 500
# setwd("/home/fronchetti/Research/JBCS-2018") # Working directory (University)
setwd("/media/fronchetti/DATA/JBCS-2018") # Working directory (Home)

pulls_summary <- read.csv("Dataset/atom/merged_pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA, NA, NA))
internals <- subset(pulls_summary, user_type == "Internals")
externals <- subset(pulls_summary, user_type == "Externals")
internals_sum <- count(internals, "number_of_days")
externals_sum <- count(externals, "number_of_days")
mar.default <- c(4,1,4,1) + 0.1
par(mar = mar.default + c(2, 2, 2, 2)) 
boxplot(externals_sum$freq, internals_sum$freq, ylim=c(0, 20), xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=2, cex.axis = 2, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), col=(c("#E6E6E6", "#727272")))
par(xpd=TRUE)
legend(0.5, 3, c("Internals", "Externals"), col=c("#727272", "#E6E6E6"), ncol=2, cex=1.7, bty = "n", text.width=c(3,2), fill = c("#727272", "#E6E6E6"))

pulls_summary <- read.csv("Dataset/electron/merged_pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA, NA, NA))
internals <- subset(pulls_summary, user_type == "Internals")
externals <- subset(pulls_summary, user_type == "Externals")
internals_sum <- count(internals, "number_of_days")
externals_sum <- count(externals, "number_of_days")
mar.default <- c(4,1,4,1) + 0.1
par(mar = mar.default + c(2, 2, 2, 2)) 
boxplot(externals_sum$freq, internals_sum$freq, ylim=c(0, 20), xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=2, cex.axis = 2, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), col=(c("#E6E6E6", "#727272")))
par(xpd=TRUE)
legend(0.5, 3, c("Internals", "Externals"), col=c("#727272", "#E6E6E6"), ncol=2, cex=1.7, bty = "n", text.width=c(3,2), fill = c("#727272", "#E6E6E6"))

pulls_summary <- read.csv("Dataset/git-lfs/merged_pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA, NA, NA))
internals <- subset(pulls_summary, user_type == "Internals")
externals <- subset(pulls_summary, user_type == "Externals")
internals_sum <- count(internals, "number_of_days")
externals_sum <- count(externals, "number_of_days")
mar.default <- c(4,1,4,1) + 0.1
par(mar = mar.default + c(2, 2, 2, 2)) 
boxplot(externals_sum$freq, internals_sum$freq, ylim=c(0, 20), xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=2, cex.axis = 2, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), col=(c("#E6E6E6", "#727272")))
par(xpd=TRUE)
legend(0.5, 3, c("Internals", "Externals"), col=c("#727272", "#E6E6E6"), ncol=2, cex=1.7, bty = "n", text.width=c(3,2), fill = c("#727272", "#E6E6E6"))

pulls_summary <- read.csv("Dataset/hubot/merged_pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA, NA, NA))
internals <- subset(pulls_summary, user_type == "Internals")
externals <- subset(pulls_summary, user_type == "Externals")
internals_sum <- count(internals, "number_of_days")
externals_sum <- count(externals, "number_of_days")
mar.default <- c(4,1,4,1) + 0.1
par(mar = mar.default + c(2, 2, 2, 2)) 
boxplot(externals_sum$freq, internals_sum$freq, ylim=c(0, 20), xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=2, cex.axis = 2, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), col=(c("#E6E6E6", "#727272")))
legend(0.5, 3, c("Internals", "Externals"), xpd = TRUE, col=c("#727272", "#E6E6E6"), ncol=2, cex=1.7, bty = "n", text.width=c(0,2), fill = c("#727272", "#E6E6E6"))

pulls_summary <- read.csv("Dataset/linguist/merged_pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA, NA, NA))
internals <- subset(pulls_summary, user_type == "Internals")
externals <- subset(pulls_summary, user_type == "Externals")
internals_sum <- count(internals, "number_of_days")
externals_sum <- count(externals, "number_of_days")
mar.default <- c(4,1,4,1) + 0.1
par(mar = mar.default + c(2, 2, 2, 2)) 
boxplot(externals_sum$freq, internals_sum$freq, ylim=c(0, 20), xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=2, cex.axis = 2, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), col=(c("#E6E6E6", "#727272")))
par(xpd=TRUE)
legend(0.5, 3, c("Internals", "Externals"), col=c("#727272", "#E6E6E6"), y.intersp = 0.5, ncol=2, cex=1.7, bty = "n", text.width=c(3,2), fill = c("#727272", "#E6E6E6"))
