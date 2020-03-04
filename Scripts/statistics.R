require("effsize")
library(distdiff)

setwd("/media/fronchetti/DATA/JBCS-2018") # Working directory (Home)

pulls_per_month <- read.csv("Dataset/linguist/pull_requests_per_month.csv", colClasses=c("Date",NA, NA, NA))

# Opened Pulls (Per Month)
data <- subset(pulls_per_month, pull_type == "opened")
internals <- data.frame(subset(data, user_type == "Internals"))
externals <- data.frame(subset(data, user_type == "Externals"))

total <- merge(internals,externals,by="month", all=TRUE)
total$pull_amount.y[is.na(total$pull_amount.y)] <- 0
total$pull_amount.x[is.na(total$pull_amount.x)] <- 0
total$pull_internal <- as.numeric(total$pull_amount.x)
total$pull_external <- as.numeric(total$pull_amount.y)

wil <- wilcox.test(total$pull_internal, total$pull_external, paired=TRUE)
wil

rFromWilcox<-function(wilcoxModel,N) {
  z<-qnorm(wilcoxModel$p.value/2)
  r<-z/sqrt(N)
  cat(wilcoxModel$data.name,"Effect Size, r=",r)
}

rFromWilcox(wil, nrow(total))

pdf("Figures/git_lfs/git_lfs_open_pr_dist.pdf",width=6,height=4) 
comp.dist.plot(total$pull_internal, total$pull_external, paired = TRUE, legend1 = "Internals", legend2 ="Externals", xlab="Pull-requests (Open)")
dev.off()

# Closed Pulls (Per Month)
data <- subset(pulls_per_month, pull_type == "closed")
internals <- data.frame(subset(data, user_type == "Internals"))
externals <- data.frame(subset(data, user_type == "Externals"))

total <- merge(internals,externals,by="month", all=TRUE)
total$pull_amount.y[is.na(total$pull_amount.y)] <- 0
total$pull_amount.x[is.na(total$pull_amount.x)] <- 0
total$pull_internal <- as.numeric(total$pull_amount.x)
total$pull_external <- as.numeric(total$pull_amount.y)

wil <- wilcox.test(total$pull_internal, total$pull_external, paired=TRUE)
wil

rFromWilcox<-function(wilcoxModel,N) {
  z<-qnorm(wilcoxModel$p.value/2)
  r<-z/sqrt(N)
  cat(wilcoxModel$data.name,"Effect Size, r=",r)
}
rFromWilcox(wil, nrow(total))

pdf("Figures/git_lfs/git_lfs_closed_pr_dist.pdf",width=6,height=4) 
comp.dist.plot(total$pull_internal, total$pull_external, paired = TRUE, legend1 = "Internals", legend2 ="Externals", xlab="Pull-requests (Closed)")
dev.off()

# Merged Pulls (Per Month)
data <- subset(pulls_per_month, pull_type == "merged")
internals <- data.frame(subset(data, user_type == "Internals"))
externals <- data.frame(subset(data, user_type == "Externals"))

total <- merge(internals,externals,by="month", all=TRUE)
total$pull_amount.y[is.na(total$pull_amount.y)] <- 0
total$pull_amount.x[is.na(total$pull_amount.x)] <- 0
total$pull_internal <- as.numeric(total$pull_amount.x)
total$pull_external <- as.numeric(total$pull_amount.y)

wil <- wilcox.test(total$pull_internal, total$pull_external, paired=TRUE)
wil 

rFromWilcox<-function(wilcoxModel,N) {
  z<-qnorm(wilcoxModel$p.value/2)
  r<-z/sqrt(N)
  cat(wilcoxModel$data.name,"Effect Size, r=",r)
}
rFromWilcox(wil, nrow(total))

pdf("Figures/git_lfs/git_lfs_merged_pr_dist.pdf",width=6,height=4) 
comp.dist.plot(total$pull_internal, total$pull_external, paired = TRUE, legend1 = "Internals", legend2 ="Externals", xlab="Pull-requests (Merged)")
dev.off()


pulls_summary <- read.csv("Dataset/linguist/merged_pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA, NA, NA))
internals <- subset(pulls_summary, user_type == "Internals")
externals <- subset(pulls_summary, user_type == "Externals")
externals <- externals[which(externals$number_of_additions != 0 | externals$number_of_deletions != 0 | externals$number_of_files_changed != 0),]
internals <- internals[which(internals$number_of_additions != 0 | internals$number_of_deletions != 0 | internals$number_of_files_changed != 0),]

# Number of additions
wilcox.test(internals$number_of_additions, externals$number_of_additions)
cliff.delta(internals$number_of_additions, externals$number_of_additions)
pdf("Figures/git_lfs/git_lfs_number_of_additions_dist.pdf",width=6,height=4) 
comp.dist.plot(internals$number_of_additions, externals$number_of_additions, legend1 = "Internals", legend2 ="Externals", xlab="Additions")
dev.off()
pdf("Figures/git_lfs/git_lfs_number_of_additions_effect.pdf",width=6,height=4) 
effsize.range.plot(internals$number_of_additions, externals$number_of_additions)
dev.off()

# Number of deletions
wilcox.test(internals$number_of_deletions, externals$number_of_deletions)
cliff.delta(internals$number_of_deletions, externals$number_of_deletions)
pdf("Figures/git_lfs/git_lfs_number_of_deletions_dist.pdf",width=6,height=4) 
comp.dist.plot(internals$number_of_deletions, externals$number_of_deletions, legend1 = "Internals", legend2 ="Externals", xlab="Deletions")
dev.off()
pdf("Figures/git_lfs/git_lfs_number_of_deletions_effect.pdf",width=6,height=4) 
effsize.range.plot(internals$number_of_deletions, externals$number_of_deletions)
dev.off()

# Number of files changed
wilcox.test(internals$number_of_files_changed, externals$number_of_files_changed)
cliff.delta(internals$number_of_files_changed, externals$number_of_files_changed)
pdf("Figures/git_lfs/git_lfs_number_of_files_changed_dist.pdf",width=6,height=4) 
comp.dist.plot(internals$number_of_files_changed, externals$number_of_files_changed, legend1 = "Internals", legend2 ="Externals", xlab="Files changed")
dev.off()
pdf("Figures/git_lfs/git_lfs_number_of_files_changed_effect.pdf",width=6,height=4) 
effsize.range.plot(internals$number_of_files_changed, externals$number_of_files_changed)
dev.off()

# Number of days
wilcox.test(internals$number_of_days, externals$number_of_days)
cliff.delta(internals$number_of_days, externals$number_of_days)
pdf("Figures/git_lfs/git_lfs_number_of_days_dist.pdf",width=6,height=4) 
comp.dist.plot(internals$number_of_days, externals$number_of_days, legends1 = "Internals", legend2 ="Externals", xlab="Number of days")
dev.off()
pdf("Figures/git_lfs/git_lfs_number_of_days_effect.pdf",width=6,height=4) 
effsize.range.plot(internals$number_of_days, externals$number_of_days)
dev.off()

# Number of commits
wilcox.test(internals$number_of_commits, externals$number_of_commits)
cliff.delta(internals$number_of_commits, externals$number_of_commits)
pdf("Figures/git_lfs/git_lfs_number_of_commits_dist.pdf",width=6,height=4) 
comp.dist.plot(internals$number_of_commits, externals$number_of_commits, legend1 = "Internals", legend2 ="Externals", xlab="Commits")
dev.off()
pdf("Figures/git_lfs/git_lfs_number_of_commits_effect.pdf",width=6,height=4) 
effsize.range.plot(internals$number_of_commits, externals$number_of_commits)
dev.off()

# Number of comments
wilcox.test(internals$number_of_comments, externals$number_of_comments)
cliff.delta(internals$number_of_comments, externals$number_of_comments)
pdf("Figures/git_lfs/git_lfs_number_of_comments_dist.pdf",width=6,height=4) 
comp.dist.plot(internals$number_of_comments, externals$number_of_comments, legend1 = "Internals", legend2 ="Externals", xlab="Comments")
dev.off()
pdf("Figures/git_lfs/git_lfs_number_of_comments_effect.pdf",width=6,height=4) 
effsize.range.plot(internals$number_of_comments, externals$number_of_comments)
dev.off()

library(plyr)
internals_sum <- count(internals, "user_login")
externals_sum <- count(externals, "user_login")

wilcox.test(internals_sum$freq, externals_sum$freq)
cliff.delta(internals_sum$freq, externals_sum$freq)
pdf("Figures/git_lfs/git_lfs_pull_requests_per_user_dist.pdf",width=6,height=4) 
comp.dist.plot(internals_sum$freq, externals_sum$freq, legend1 = "Internals", legend2 ="Externals", xlab="Pull-requests (Frequency per user)")
dev.off()
pdf("Figures/git_lfs/git_lfs_pull_requests_per_user_effec.pdf",width=6,height=4) 
effsize.range.plot(internals_sum$freq, externals_sum$freq)
dev.off()
