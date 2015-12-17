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

# sum emissions by year for these emission types in Baltimore
vehicle <- NEI[NEI$fips == "24510", ][NEI$SCC %in% codes, ] %>%
  group_by(year) %>%
  summarise(Totals = round(sum(Emissions), digits = 0))

# fix NA
vehicle <- vehicle[!is.na(vehicle$year), ]

# show a clean bar chart with values on top
png("plot5.png", width = 480, height = 480)
p <- ggplot(data=vehicle, aes(x=factor(year), y=Totals)) +
  geom_bar(stat="identity") +
  geom_text(aes(label = Totals), size = 5, vjust = -0.5, position = "identity") +
  xlab("Year") +
  ylab("Tons") +
  ggtitle("Emissions from motor vehicle sources in Baltimore City")
p + theme(axis.text.y=element_blank(), axis.ticks=element_blank())
dev.off()

# emissions from motor vehicle sources fluctuated wildly from 1999–2008 in Baltimore City,
# but comparing 2008 and 1999 we can see an actual decrease