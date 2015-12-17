# set working directory
setwd('Desktop/r/analysis_2')

# load dplyr for data shaping
library(dplyr)

# load source files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# sum emissions by year in Baltimore
summary <- NEI[NEI$fips == "24510", ] %>%
  group_by(year) %>%
  summarise(Totals = sum(Emissions))

# plot with bar chart because these are discrete values, not continous ones
png("plot2.png", width = 480, height = 480)
summary_plot <- barplot(summary$Totals, main="Total PM2.5 Emissions in Baltimore City", ylab = "Tons", yaxt="n", names.arg = summary$year)
# add values to bars
text(cex=.8, xpd=TRUE, x=summary_plot,y=summary$Totals,label=format(summary$Totals), po=3)
dev.off()

# yes, total emissions decreased from PM2.5 in Baltimore, although there was a bump in 2005