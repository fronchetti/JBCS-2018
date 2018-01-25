# install.packages("ggplot2")
# install.packages("reshape2")
# install.packages("scales")
library(ggplot2)
library(reshape2)
library(scales)

setwd("/home/fronchetti/Documentos/JBCS-2018") # Working directory

##################
# PULL REQUESTS  #
#   PER MONTH    #
##################
# File type: EPS
# Chart type: Time series (Line)
# W: 600 H: 400

# Change the path according to the project
pulls_per_month <- read.csv("Dataset/linguist/pull_requests_per_month.csv", colClasses=c("Date",NA, NA, NA))

data <- subset(pulls_per_month, pull_type == "opened")
ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type)) +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title.x = element_text(face="bold"), axis.title.y = element_text(face="bold"), legend.title=element_blank(), legend.position="top")
dev.copy2eps(file="Images/linguist/linguist_opened_pulls_series.eps", width = 6, height = 4)

data <- subset(pulls_per_month, pull_type == "merged")
ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type)) +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title.x = element_text(face="bold"), axis.title.y = element_text(face="bold"), legend.title=element_blank(), legend.position="top")
dev.copy2eps(file="Images/linguist/linguist_merged_pulls_series.eps", width = 6, height = 4)

data <- subset(pulls_per_month, pull_type == "closed")
ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type)) +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title.x = element_text(face="bold"), axis.title.y = element_text(face="bold"), legend.title=element_blank(), legend.position="top")
dev.copy2eps(file="Images/linguist/linguist_closed_pulls_series.eps", width = 6, height = 4)

##################
# PULL REQUESTS  #
#    SUMMARY     #
##################
# File type: EPS
# Chart type: Boxplot
# W: 650 H: 360

pulls_summary <- read.csv("Dataset/linguist/pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA))

employees <- subset(pulls_summary, user_type == "Employees")
volunteers <- subset(pulls_summary, user_type == "Volunteers")

boxplot(volunteers$number_of_commits, employees$number_of_commits, xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=1.2, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), col=(c("#b8d1ed", "#aae0c0")))
legend("topright", legend=c("Employees", "Volunteers"), fill=c("#aae0c0", "#b8d1ed"), inset= .0, cex=0.6, ncol=1)
dev.copy2eps(file="Images/linguist/linguist_commits_amount.eps", width = 6.5, height = 3.6)

boxplot(volunteers$number_of_comments, employees$number_of_comments, xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=1.2, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), col=(c("#b8d1ed", "#aae0c0")))
legend("topright", legend=c("Employees", "Volunteers"), fill=c("#aae0c0", "#b8d1ed"), inset= .0, cex=0.6, ncol=1)
dev.copy2eps(file="Images/linguist/linguist_comments_amount.eps", width = 6.5, height = 3.6)

mar.default <- c(5,4,4,2) + 0.1
par(mar = mar.default + c(0, 4, 0, 0)) 
boxplot(volunteers$number_of_additions, employees$number_of_additions, volunteers$number_of_deletions, employees$number_of_deletions, volunteers$number_of_files_changed, employees$number_of_files_changed, xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=1.2, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), at = c(1,2,4,5,7,8), col=(c("#b8d1ed", "#aae0c0","#b8d1ed", "#aae0c0","#b8d1ed", "#aae0c0")))
mtext("Files Changed", side=2, at=1.5, las=1, outer=FALSE, adj=1.1)
mtext("Deletions", side=2, at=4.5, las=1, outer=FALSE, adj=1.2)
mtext("Additions", side=2, at=7.5, las=1, outer=FALSE, adj=1.2)
legend("topright", legend=c("Employees", "Volunteers"), fill=c("#aae0c0", "#b8d1ed"), inset= .0, cex=0.6, ncol=1)
dev.copy2eps(file="Images/linguist/linguist_changes_amount.eps", width = 8.5, height = 4.6)
dev.off()

employees <- subset(pulls_per_month, user_type == "Employees", pull_type="merged")
volunteers <- subset(pulls_per_month, user_type == "Volunteers", pull_type="merged")
boxplot(volunteers$pull_amount, employees$pull_amount, xlab="# Occurrences", las = 1, outline = FALSE, cex.lab=1.2, horizontal = TRUE, margin = list(l = 10, r = 10, b = 0, t = 0), col=(c("#b8d1ed", "#aae0c0")))
legend("topright", legend=c("Employees", "Volunteers"), fill=c("#aae0c0", "#b8d1ed"), inset= .0, cex=0.6, ncol=1)
dev.copy2eps(file="Images/linguist/linguist_pulls_amount.eps", width = 6.5, height = 3.6)

