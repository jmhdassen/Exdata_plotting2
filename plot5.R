
library(plyr)
library(dplyr)
library(ggplot2)

##setwd("F:\\Coursera\\04_ExploratoryAnalysis\\Course Projects\\Project2")
#setwd("/Users/dassen/Documents/Coursera/04_ExploratoryAnalysis/Course Projects/Project2")
## This first line will likely take a few seconds. Be patient!
##NEI <- readRDS("summarySCC_PM25.rds")
##SCC <- readRDS("Source_Classification_Code.rds")

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

NEI_BC <- NEI[NEI$fips =="24510",]

# Vector of the sources related to Vehicles
SCC_vehicle<-SCC[grep("Vehicle", SCC$SCC.Level.Two),]

## Plot 5
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
# 

## Get the emissions from Vehicle Sources for Baltimore totals by Year
##NEI_BC_veh <- NEI_BC[NEI_BC$SCC %in% SCC_vehicle$SCC,]
NEI_BC_veh_total <- ddply(NEI_BC[NEI_BC$SCC %in% SCC_vehicle$SCC,],.(year),summarize,total=sum(Emissions))
NEI_BC_veh_total <- mutate(NEI_BC_veh_total,change=NEI_BC_veh_total$total/NEI_BC_veh_total$total[1],city="Baltimore")

##NEI_LA_veh <- NEI_LA[NEI_LA$SCC %in% SCC_vehicle$SCC,]
##NEI_LA_veh_total <- mutate(NEI_LA_veh_total,change=NEI_LA_veh_total$total/NEI_LA_veh_total$total[1],city="Los Angeles")
##NEI_veh_total <- rbind(NEI_LA_veh_total,NEI_BC_veh_total)

g2 <- ggplot(NEI_BC_veh_total, aes(year, total))
g2 <- g2 + geom_point(aes(color=city))
g2 <- g2 + geom_line(size = 2, color="red")
g2 <- g2 + scale_x_continuous("Year",limits=c(1999,2008))
g2 <- g2 + scale_y_continuous("PM2.5 in tons",limits=c(0,420))
g2 <- g2 + theme( legend.position = "none", legend.key = element_rect(colour = "grey"),
                  legend.title = element_text(size=14),
                  legend.text = element_text(size=14),
                  axis.text = element_text(color = "black", size=10 ),
                  axis.title.x = element_text(color = "black", size=12 ),
                  axis.title.y = element_text(color = "black", size=12 ),
                  plot.title = element_text(size=18, face="bold", color="black"))
g2 <- g2 + ggtitle(expression(atop("Vehicle PM2.5 Emission over Time (starting 1999)", atop(italic("Baltimore"), ""))))
g2

ggsave("plot5.png", g2, dpi = 300, scale = 0.5)

