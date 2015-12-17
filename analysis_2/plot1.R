# set working directory
setwd('Desktop/r/analysis_2')

# load dplyr for data shaping
library(dplyr)

# load source files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# sum emissions by year
totals <- NEI %>%
  group_by(year) %>%
  summarise(Totals = sum(Emissions))

# plot with bar chart because these are discrete values, not continous ones
png("plot1.png", width = 480, height = 480)
summary_plot <- barplot(totals$Totals, main="Total PM2.5 Emissions in the US", ylab = "Tons", yaxt="n", names.arg = totals$year)
# add values to bars
text(cex=.8, xpd=TRUE, x=summary_plot, y=totals$Totals,label=format(totals$Totals), po=3)
dev.off()

# yes, total emissions from PM2.5 decreased in the United States from 1999 to 2008