corr<- function(directory, threshold = 0) {  
  filenames <- dir(directory, pattern =".csv")
  collection <- numeric()
  for(filename in filenames) {
    con <- file(paste(directory, "/", filename, sep=""), "r")
    data <- read.csv(con)
    close(con)
    if (sum(complete.cases(data)) > threshold) {
      corr = cor(data["sulfate"][complete.cases(data), ], data["nitrate"][complete.cases(data), ])
      collection <- c(collection, corr)
      }
    }
  collection
  }

# complete("specdata", c(2, 4, 8, 10, 12))
