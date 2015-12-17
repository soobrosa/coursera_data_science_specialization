rankhospital <- function(state, outcome, num = "best") {
  
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
  
  ## Check that state and outcome are valid  
  if (!(state %in% state.abb)) {
    stop("invalid state")    
  } 
  if (!(outcome %in% valid_outcomes)) {
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with the given rank 30-day death rate
  
  column <- outcome_columns[match(outcome, valid_outcomes)]
  stately <- datafile[datafile[7] == state, ]
  ordered <- stately[order(as.numeric(stately[, column]), stately[, 2], na.last = NA, decreasing = revers),]
  ordered[rank, 2]
}