best <- function(state, outcome) {
  
  valid_outcomes = c("heart attack", "heart failure", "pneumonia")
  outcome_columns = c(11, 17, 23)
  
  ## Read outcome data
  
  datafile <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  
  if (!(state %in% state.abb)) {
    stop("invalid state")    
  }
  
  if (!(outcome %in% valid_outcomes)) {
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with lowest 30-day death rate
  
  column = outcome_columns[match(outcome, valid_outcomes)]
  stately = datafile[datafile[7] == state, ]
  best = min(as.numeric(stately[, column]), na.rm = TRUE)
  sort(stately[as.numeric(stately[, column]) == best, 2])[1]
}