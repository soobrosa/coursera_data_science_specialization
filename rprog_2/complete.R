complete <- function(directory, id = 1:332) {  
  collection <- as.data.frame(matrix(nrow = length(id), ncol = 2))
  dimnames(collection) <- list(1:length(id), c("id", "nobs"))
  cid <- 1
  for(index in id) {
    # getting a proper filename
    temp = paste("00", toString(index), sep = "")
    strlen = nchar(temp)
    filename = paste(directory, "/" , substr(temp,(nchar(temp)+1)-3,nchar(temp)), ".csv", sep = "")
    con <- file(filename, "r")
    data <- read.csv(con)
    close(con)
    collection[cid, 1] <- c(index)
    collection[cid, 2] <- c(sum(complete.cases(data)))
    cid <- cid + 1
  }
  collection
  }

# complete("specdata", c(2, 4, 8, 10, 12))
