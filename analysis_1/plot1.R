setwd('Desktop/r/analysis_1')
filename <- 'household_power_consumption.txt'

cols <- c("character", "character", rep('numeric', 7))
all_rows <- read.table(filename, header = TRUE, sep = ';', colClasses = cols, na.strings=c("?"), stringsAsFactors=FALSE)

first_day = all_rows[all_rows$Date == '1/2/2007', ]
second_day = all_rows[all_rows$Date == '2/2/2007', ]
both_days = rbind(first_day, second_day)

png("plot1.png", width = 480, height = 480)
with(both_days, hist(Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()

png("plot2.png", width = 480, height = 480)
both_days$timestamp <- as.POSIXct(strptime(paste(both_days$Date, both_days$Time), "%d/%m/%Y %H:%M:%S"))
with(both_days, plot(timestamp, Global_active_power, type ="l", xlab=NA, ylab = "Global Active Power (kilowatts)"))
dev.off()

png("plot3.png", width = 480, height = 480)
with(both_days, {
  plot(timestamp, Sub_metering_1, main = NA, xlab = NA, ylab = NA, type ="l", col = "black")
  lines(timestamp, Sub_metering_2, col = "red")
  lines(timestamp, Sub_metering_3, col = "blue")
  title(ylab="Energy sub metering")
})
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(both_days, plot(timestamp, Global_active_power, type ="l", xlab=NA, ylab = "Global Active Power"))
with(both_days, plot(timestamp, Voltage, type ="l", xlab="datetime", ylab = "Voltage"))
with(both_days, {
  plot(timestamp, Sub_metering_1, main = NA, xlab = NA, ylab = NA, type ="l", col = "black")
  lines(timestamp, Sub_metering_2, col = "red")
  lines(timestamp, Sub_metering_3, col = "blue")
  title(ylab="Energy sub metering")
})
legend("topright", lwd = 1, box.col = "white", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(both_days, plot(timestamp, Global_reactive_power, type ="l", xlab="datetime", ylab = "Global_reactive_power"))
dev.off()
