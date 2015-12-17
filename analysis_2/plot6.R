# set working directory
setwd('Desktop/r/analysis_2')

# load dplyr for data shaping
library(dplyr)

# load source files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load ggplot2
library(ggplot2)

# filter emission types by sector names containing 'Vehicle'
codes = SCC[grep("Vehicle", SCC$EI.Sector), 1]

# sum emissions by year for these emission types in Baltimore and Los Angeles
vehicle <- NEI[NEI$fips == "24510" | NEI$fips == "06037", ][NEI$SCC %in% codes, ] %>%
  group_by(fips, year) %>%
  summarise(Totals = round(sum(Emissions), digits = 0))

# fix NA
vehicle <- vehicle[!is.na(vehicle$year), ]

# fix geographical names
vehicle$fips[vehicle$fips == "24510"] <- "Baltimore City"
vehicle$fips[vehicle$fips == "06037"] <- "Los Angeles County"

# show each type in a sub-chart to better see changes
png("plot6.png", width = 480, height = 480)
p <- ggplot(data=vehicle, aes(x=fips, y=Totals, group=year, fill=year)) +
  geom_bar(stat="identity", position=position_dodge()) +
  ylab("Tons") +
  ggtitle("Emissions from motor vehicle sources in two locations")
p + theme(axis.title.x=element_blank(), axis.ticks=element_blank())
dev.off()

# both Baltimore City and Los Angeles County seen volatility in emission from motor vehicle
# sources, the changes were bigger in relative terms in Baltimore, while in absolute terms
# they were bigger in Los Angeles County - levels decreased in both places, although
# Los Angeles shows an increasing trend