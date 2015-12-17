rankall <- function(outcome, num = "best") {
  
  valid_outcomes = c("heart attack", "heart failure", "pneumonia")
  outcome_columns = c(11, 17, 23)
  
  revers = FALSE
  
  if (num == "best") {
    rank = 1
  } else {
    if (num == "worst") {
      revers = TRUE
      rank = 1
    } else {
      rank = as.numeric(num)
    }
  }
  
  ## Read outcome data
  datafile <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that outcome are valid  
  if (!(outcome %in% valid_outcomes)) {
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with the given rank 30-day death rate
  
  states <- unique(datafile[, 7])
  output <- matrix(ncol = 2, nrow = length(states))
  rownames(output) <- states
  colnames(output) <- c("hospital", "state")
  column <- outcome_columns[match(outcome, valid_outcomes)]
  ordered <- datafile[order(datafile[, 7],
                            as.numeric(datafile[, column]),
                            datafile[, 2],
                            na.last = NA,
                            decreasing = revers),]
  for (state in states) {
    output[state, 1] <- ordered[ordered[7] == state, ][rank, 2]
    output[state, 2] <- state
  }
  data.frame(output[order(output[, 2]), ])
}