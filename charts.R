# install.packages("ggplot2")
# install.packages("reshape2")
# install.packages("scales")
library(ggplot2)
library(reshape2)
library(scales)

setwd("/home/fronchetti/Documentos/JBCS-2018") # Working directory

##################
# PULL REQUESTS  #
##################

# File type: EPS
# W: 600 H: 400

pulls <- read.csv("Dataset/atom/pulls.csv", colClasses=c("Date",NA, NA, NA))

data <- subset(pulls, pull_type == "opened")
ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type)) +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# PRs") + theme(axis.title.x = element_text(face="bold"), axis.title.y = element_text(face="bold"), legend.title=element_blank(), legend.position="top")

data <- subset(pulls, pull_type == "merged")
ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type)) +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# PRs") + theme(axis.title.x = element_text(face="bold"), axis.title.y = element_text(face="bold"), legend.title=element_blank(), legend.position="top")

data <- subset(pulls, pull_type == "closed")
ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type)) +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# PRs") + theme(axis.title.x = element_text(face="bold"), axis.title.y = element_text(face="bold"), legend.title=element_blank(), legend.position="top")

