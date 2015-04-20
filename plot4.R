
library(plyr)
library(dplyr)
library(ggplot2)

#setwd("F:\\Coursera\\04_ExploratoryAnalysis\\Course Projects\\Project2")
#setwd("/Users/dassen/Documents/Coursera/04_ExploratoryAnalysis/Course Projects/Project2")
## This first line will likely take a few seconds. Be patient!
##NEI <- readRDS("summarySCC_PM25.rds")
##SCC <- readRDS("Source_Classification_Code.rds")


# Get a vector with the source id's which are related to Coal and Combustion
SCC_coal_comb<-SCC[intersect(grep("Coal", SCC$SCC.Level.Three), grep("Combustion", SCC$SCC.Level.One)),]

## Plot 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# 

# create the data frames with only the source id's created above
NEI_cc <- NEI[NEI$SCC %in% SCC_coal_comb$SCC,]
NEI_cc_total <- ddply(NEI[NEI$SCC %in% SCC_coal_comb$SCC,],.(year),summarize,total=sum(Emissions)/1000)
barplot(NEI_cc_total$total, names.arg=unique(NEI_cc_total$year), ylab="PM2.5 ktons", main="PM2.5 Emissions from Coal Combustion for USA in thousand tons", col="wheat3")

png(file="plot4.png", width = 480, height = 480)
barplot(NEI_cc_total$total, names.arg=unique(NEI_cc_total$year), ylab="PM2.5 ktons", main="PM2.5 Emissions from Coal Combustion for USA in thousand tons", col="wheat3")
dev.off()

