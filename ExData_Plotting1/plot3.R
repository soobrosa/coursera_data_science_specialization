setwd('Desktop/r/analysis_1')
filename <- 'household_power_consumption.txt'

cols <- c("character", "character", rep('numeric', 7))
all_rows <- read.table(filename, header = TRUE, sep = ';', colClasses = cols, na.strings=c("?"), stringsAsFactors=FALSE)

first_day = all_rows[all_rows$Date == '1/2/2007', ]
second_day = all_rows[all_rows$Date == '2/2/2007', ]
both_days = rbind(first_day, second_day)

png("plot3.png", width = 480, height = 480)
with(both_days, {
  plot(timestamp, Sub_metering_1, main = NA, xlab = NA, ylab = NA, type ="l", col = "black")
  lines(timestamp, Sub_metering_2, col = "red")
  lines(timestamp, Sub_metering_3, col = "blue")
  title(ylab="Energy sub metering")
})
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
