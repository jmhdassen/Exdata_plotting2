
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

##Plot 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

# Sum totals for Baltimare by Year and Type 
NEI_BC_total_by_type<-ddply(NEI_BC,.(year,type),summarize,total=sum(Emissions)/1000)

g <- ggplot(NEI_BC_total_by_type, aes(year, total))
g <- g + geom_point(aes(color=type), size=4)
g <- g + geom_line(aes(group = type, colour = type), size = 1)
g <- g + scale_x_continuous("Year",limits=c(1999,2008))
g <- g + scale_y_continuous("Emission of PM2.5 in ktons",limits=c(0,2.5))
g <- g + theme( legend.position = "right", legend.key = element_rect(colour = "grey"),
                   legend.title = element_text(size=16),
                   legend.text = element_text(size=16),
                   axis.text = element_text(color = "black", size=14 ),
                   axis.title.x = element_text(color = "black", size=14 ),
                   axis.title.y = element_text(color = "black", size=14 ),
                   plot.title = element_text(size=25, face="bold", color="black"))
g <- g + ggtitle(expression(atop("PM2.5 Emission for Baltimore, Maryland", atop(italic("By Type"), ""))))
g

ggsave("plot3.png", g, dpi = 300, scale = 0.5)

