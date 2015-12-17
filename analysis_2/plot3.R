# set working directory
setwd('Desktop/r/analysis_2')

# load dplyr for data shaping
library(dplyr)

# load source files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load ggplot2
library(ggplot2)

# sum emissions by type and year in Baltimore
sources <- NEI[NEI$fips == "24510", ] %>%
  group_by(type, year) %>%
  summarise(Totals = sum(Emissions))

# show each type in a sub-chart to better see changes
png("plot3.png", width = 480, height = 480)
ggplot(data=sources, aes(x=type, y=Totals, group=year, fill=year)) +
  geom_bar(stat="identity", position=position_dodge()) +
  xlab("Type") +
  ylab("Tons") +
  ggtitle("Emissions in Baltimore City by type")
dev.off()

# non-road, non-point and on-road seen decreases in Baltimore, while point slightly increased
# after a serious upwards bump