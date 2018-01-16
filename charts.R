# install.packages("ggplot2")
# install.packages("reshape2")
# install.packages("scales")
library(ggplot2)
library(reshape2)
library(scales)

setwd("/home/fronchetti/Documentos/JBCS-2018") # Working directory

####################
#   Time series    #
####################

# PULL REQUESTS
monthly <- read.csv("Dataset/hubot/pulls.csv", colClasses=c("Date",NA, NA, NA))
data <- subset(monthly, user_type == "employees")

ggplot(monthly, aes(x=month, y=pull_amount, colour=pull_type, group=pull_type)) +
  scale_x_date(breaks = date_breaks("years"), labels = date_format("%Y")) + 
  geom_line(size=1.2, aes(linetype = pull_type))
