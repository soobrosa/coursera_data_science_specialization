setwd('Desktop/r/analysis_1')
filename <- 'household_power_consumption.txt'

cols <- c("character", "character", rep('numeric', 7))
all_rows <- read.table(filename, header = TRUE, sep = ';', colClasses = cols, na.strings=c("?"), stringsAsFactors=FALSE)

first_day = all_rows[all_rows$Date == '1/2/2007', ]
second_day = all_rows[all_rows$Date == '2/2/2007', ]
both_days = rbind(first_day, second_day)

png("plot2.png", width = 480, height = 480)
both_days$timestamp <- as.POSIXct(strptime(paste(both_days$Date, both_days$Time), "%d/%m/%Y %H:%M:%S"))
with(both_days, plot(timestamp, Global_active_power, type ="l", xlab=NA, ylab = "Global Active Power (kilowatts)"))
dev.off()
