
library(plyr)
library(dplyr)
library(ggplot2)

#setwd("F:\\Coursera\\04_ExploratoryAnalysis\\Course Projects\\Project2")
#setwd("/Users/dassen/Documents/Coursera/04_ExploratoryAnalysis/Course Projects/Project2")
## This first line will likely take a few seconds. Be patient!
##NEI <- readRDS("summarySCC_PM25.rds")
##SCC <- readRDS("Source_Classification_Code.rds")

NEI_BC <- NEI[NEI$fips =="24510",]
##NEI_LA <- NEI[NEI$fips =="06037",]

# Plot 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
NEI_BC_total<-ddply(NEI_BC,.(year),summarize,total=sum(Emissions)/1000)

barplot(NEI_BC_total$total, names.arg=unique(NEI_BC_total$year), ylab="PM2.5 ktons", main="PM2.5 Emissions for Baltimore City, Maryland in thousand tons", col="wheat1")
png(file="plot2.png", width = 480, height = 480)
barplot(NEI_BC_total$total, names.arg=unique(NEI_BC_total$year), ylab="PM2.5 ktons", main="PM2.5 Emissions for Baltimore City, Maryland in thousand tons", col="wheat1")
dev.off()

