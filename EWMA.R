
# Exponentially Weighted Moving Average Function is designed to use for self in validation tool.

library(fPortfolio)

x.weight <- function(lamda,days){
  k <- lamda
  days <- 252
  i <- 1
  for(j in days:1) {
    weight <- (1-k) * k ^ (j-1)
    x[i] <- weight
    i = i +1
  }
  return(x)
}

EWMA <- function(x,lamda=0.94,days=252){
  
  x = as.matrix(x)
  weight = x.weight(lamda,days)
  y = apply(x,2,returns)
  y = na.omit(y)
  mu = apply(y,2,mean)
  k = apply(y,2,function(y){weight*(y-mu)^2})
  
  EWMA = apply(k,2,sum)
  EWMA = sqrt(EWMA)
  
  return(EWMA)
  
}
