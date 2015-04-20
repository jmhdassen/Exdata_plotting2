
library(plyr)
library(dplyr)
library(ggplot2)

#setwd("F:\\Coursera\\04_ExploratoryAnalysis\\Course Projects\\Project2")
#setwd("/Users/dassen/Documents/Coursera/04_ExploratoryAnalysis/Course Projects/Project2")
## This first line will likely take a few seconds. Be patient!
##NEI <- readRDS("summarySCC_PM25.rds")
##SCC <- readRDS("Source_Classification_Code.rds")

NEI_BC <- NEI[NEI$fips =="24510",]
NEI_LA <- NEI[NEI$fips =="06037",]

# Vector of the sources related to Vehicles
SCC_vehicle<-SCC[grep("Vehicle", SCC$SCC.Level.Two),]

# Sum total Emissions for Baltimore and LA for Vehicle sources by Year
NEI_BC_veh_total <- ddply(NEI_BC[NEI_BC$SCC %in% SCC_vehicle$SCC,],.(year),summarize,total=sum(Emissions))
NEI_LA_veh_total <- ddply(NEI_LA[NEI_LA$SCC %in% SCC_vehicle$SCC,],.(year),summarize,total=sum(Emissions))

## Combine in one frame and calculate the change from first year as a percentage 
NEI_LA_veh_total <- mutate(NEI_LA_veh_total,change=100*NEI_LA_veh_total$total/NEI_LA_veh_total$total[1],city="Los Angeles")
NEI_BC_veh_total <- mutate(NEI_BC_veh_total,change=100*NEI_BC_veh_total$total/NEI_BC_veh_total$total[1],city="Baltimore")
NEI_veh_total <- rbind(NEI_LA_veh_total,NEI_BC_veh_total)


# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
# 


g4 <- ggplot(NEI_veh_total, aes(year, change))
g4 <- g4 + geom_point(aes(color=city))
g4 <- g4 + geom_line(size = 2, color="red", data=NEI_veh_total[NEI_veh_total$city=='Baltimore',])
g4 <- g4 + geom_line(size = 2, color="cyan", data=NEI_veh_total[NEI_veh_total$city=='Los Angeles',])
g4 <- g4 + scale_x_continuous("Year",limits=c(1999,2008))
g4 <- g4 + scale_y_continuous("Percent Change in PM2.5",limits=c(0,150))
g4 <- g4 + theme( legend.position = "right", legend.key = element_rect(colour = "grey"),
                  legend.title = element_text(size=14),
                  legend.text = element_text(size=14),
                  axis.text = element_text(color = "black", size=10 ),
                  axis.title.x = element_text(color = "black", size=12 ),
                  axis.title.y = element_text(color = "black", size=12 ),
                  plot.title = element_text(size=18, face="bold", color="black"))
g4 <- g4 + ggtitle(expression(atop("Comparison Vehicle Emission Change over Time (starting 1999)", atop(italic("By City"), ""))))
g4

ggsave("plot6.png", g4, dpi = 300, scale = 0.5)

