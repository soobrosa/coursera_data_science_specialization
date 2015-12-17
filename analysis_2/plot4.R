# set working directory
setwd('Desktop/r/analysis_2')

# load dplyr for data shaping
library(dplyr)

# load source files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load ggplot2
library(ggplot2)

# filter emission types by sector names containing 'Coal'
codes = SCC[grep("Coal", SCC$EI.Sector), 1]

# sum emissions by year for these emission types
coal <- NEI[NEI$SCC %in% codes, ] %>%
  group_by(year) %>%
  summarise(Totals = round(sum(Emissions), digits = 0))

# show a clean bar chart with values on top
png("plot4.png", width = 480, height = 480)
p <- ggplot(data=coal, aes(x=factor(year), y=Totals)) +
  geom_bar(stat="identity") +
  geom_text(aes(label = Totals), size = 5, vjust = -0.5, position = "identity") +
  xlab("Year") +
  ylab("Tons") +
  ggtitle("Emissions from coal combustion-related sources in the US")
p + theme(axis.text.y=element_blank(), axis.ticks=element_blank())
dev.off()

# emissions from coal combustion-related sources decreased in the US