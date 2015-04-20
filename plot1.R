library(plyr)
library(dplyr)
library(ggplot2)

setwd("/Users/dassen/Documents/Coursera/04_ExploratoryAnalysis/Course Projects/Project2")
#setwd("/Users/dassen/Documents/Coursera/04_ExploratoryAnalysis/Course Projects/Project2")
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## there are a few extremely high values which are sure to be outliers; we remove them.
emision_outlyers<-NEI$Emissions>50000

## Sum total the emissions by Year (excluding the outliers)
NEI_sum_total<-ddply(NEI[!emision_outlyers,],.(year),summarize,total=sum(Emissions)/1000000)

# Plot 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
NEI_sum_total<-ddply(NEI[!emision_outlyers,],.(year),summarize,total=sum(Emissions)/1000000)
barplot(NEI_sum_total$total, names.arg=unique(NEI_sum_total$year), ylab="PM2.5 Mtons", main="PM2.5 Emissions for USA in million tons", col="wheat3")

png(file="plot1.png", width = 480, height = 480)
barplot(NEI_sum_total$total, names.arg=unique(NEI_sum_total$year), ylab="PM2.5 Mtons", main="PM2.5 Emissions for USA in million tons", col="wheat3")
dev.off()

