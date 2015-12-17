pollutantmean <- function(directory, pollutant, id = 1:332) {  
  collection <- numeric()
  for(index in id) {
    # getting a proper filename
    temp = paste("00", toString(index), sep = "")
    strlen = nchar(temp)
    filename = paste(directory, "/" , substr(temp,(nchar(temp)+1)-3,nchar(temp)), ".csv", sep = "")
    con <- file(filename, "r")
    data <- read.csv(con)
    close(con)
    collection = c(collection, data[, pollutant])
  }
  mean(collection, na.rm = TRUE)
  }
