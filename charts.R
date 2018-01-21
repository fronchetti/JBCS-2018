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
pulls_per_month <- read.csv("Dataset/atom/pull_requests_per_month.csv", colClasses=c("Date",NA, NA, NA))

data <- subset(pulls_per_month, pull_type == "opened")
ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type)) +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# PRs") + theme(axis.title.x = element_text(face="bold"), axis.title.y = element_text(face="bold"), legend.title=element_blank(), legend.position="top")

data <- subset(pulls_per_month, pull_type == "merged")
ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type)) +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# PRs") + theme(axis.title.x = element_text(face="bold"), axis.title.y = element_text(face="bold"), legend.title=element_blank(), legend.position="top")

data <- subset(pulls_per_month, pull_type == "closed")
ggplot(data, aes(x=month, y=pull_amount, colour=user_type, group=user_type)) +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y"), limits = as.Date(c('2011-01-01','2018-02-01'))) + ylim(0, 80) + 
  geom_line(size=1.2, aes(linetype = user_type)) + scale_color_manual(values=c("#00C853", "#1565C0")) + 
  labs(x = "Years", y = "# PRs") + theme(axis.title.x = element_text(face="bold"), axis.title.y = element_text(face="bold"), legend.title=element_blank(), legend.position="top")

##################
# PULL REQUESTS  #
#    SUMMARY     #
##################
# File type: EPS
# Chart type: Boxplot
# W: ? H: ?

pulls_summary <- read.csv("Dataset/atom/pull_requests_summary.csv", colClasses=c(NA, NA, NA, NA, NA, NA, "Date", NA, NA, NA))
