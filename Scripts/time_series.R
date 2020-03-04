library(reshape2)
library(scales)
library(ggplot2)
library(grid)
library(gridExtra)
library(ggpubr)


setwd("/home/fronchetti/Documentos/JBCS-2018") # Working directory
par(mfrow=c(5,3))

#
# Atom
#
pulls_per_month <- read.csv("Dataset/atom/pull_requests_per_month.csv", colClasses=c("Date",NA, NA, NA))
#Opened
data <- subset(pulls_per_month, pull_type == "opened")
atom_opened <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type)) + ggtitle("") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
# Merged
data <- subset(pulls_per_month, pull_type == "merged")
atom_merged <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type)) + ggtitle("") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
# Closed
data <- subset(pulls_per_month, pull_type == "closed")
atom_closed <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type)) + ggtitle("Atom") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), plot.title = element_text(hjust = 0.5, face = "bold", size = 26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
#
# Electron
#
pulls_per_month <- read.csv("Dataset/electron/pull_requests_per_month.csv", colClasses=c("Date",NA, NA, NA))
#Opened
data <- subset(pulls_per_month, pull_type == "opened")
electron_opened <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type))  + ggtitle("") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
# Merged
data <- subset(pulls_per_month, pull_type == "merged")
electron_merged <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type))  + ggtitle("") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
# Closed
data <- subset(pulls_per_month, pull_type == "closed")
electron_closed <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type))  + ggtitle("Electron") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), plot.title = element_text(hjust = 0.5, face = "bold", size = 26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
#
# Git-lfs
#
pulls_per_month <- read.csv("Dataset/git-lfs/pull_requests_per_month.csv", colClasses=c("Date",NA, NA, NA))
#Opened
data <- subset(pulls_per_month, pull_type == "opened")
git_lfs_opened <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type))  + ggtitle("") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
# Merged
data <- subset(pulls_per_month, pull_type == "merged")
git_lfs_merged <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type))  + ggtitle("") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
# Closed
data <- subset(pulls_per_month, pull_type == "closed")
git_lfs_closed <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type))  + ggtitle("Git-lfs") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), plot.title = element_text(hjust = 0.5, face = "bold", size = 26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
#
# Hubot
#
pulls_per_month <- read.csv("Dataset/hubot/pull_requests_per_month.csv", colClasses=c("Date",NA, NA, NA))
#Opened
data <- subset(pulls_per_month, pull_type == "opened")
hubot_opened <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type))  + ggtitle("") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
# Merged
data <- subset(pulls_per_month, pull_type == "merged")
hubot_merged <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type))  + ggtitle("") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
# Closed
data <- subset(pulls_per_month, pull_type == "closed")
hubot_closed <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type))  + ggtitle("Hubot") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), plot.title = element_text(hjust = 0.5, face = "bold", size = 26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
#
# Linguist
#
pulls_per_month <- read.csv("Dataset/linguist/pull_requests_per_month.csv", colClasses=c("Date",NA, NA, NA))
#Opened
data <- subset(pulls_per_month, pull_type == "opened")
linguist_opened <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type))  + ggtitle("") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
# Merged
data <- subset(pulls_per_month, pull_type == "merged")
linguist_merged <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type))  + ggtitle("") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))
# Closed
data <- subset(pulls_per_month, pull_type == "closed")
linguist_closed <- ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type))  + ggtitle("Linguist") +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# Occurrences") + theme(axis.title=element_text(size=16), legend.text=element_text(size=26), plot.title = element_text(hjust = 0.5, face = "bold", size = 26), legend.title=element_blank(), axis.text=element_text(size=22), legend.position="top", axis.text.x = element_text(angle = 45, hjust = 1, size=14, color="#000000"), axis.text.y = element_text(size=16, color="#000000"))


ggarrange(atom_opened, atom_closed, atom_merged, electron_opened, electron_closed, electron_merged, git_lfs_opened, git_lfs_closed, git_lfs_merged, hubot_opened, hubot_closed, hubot_merged, linguist_opened, linguist_closed, linguist_merged, nrow=5, ncol=3, common.legend = TRUE, legend="top")
dev.copy2eps(file="Images/time_series.eps", width = 13, height = 16)
dev.off()

