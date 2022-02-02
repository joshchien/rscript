
fxlocal <- function(fx){
     if(fx[1,] == "AUD"||fx[1,] == "EUR"||fx[1,] == "GBP"||fx[1,] == "NZD"){
        answer = fx[1,2]
     }else{
       answer = 1/fx[1,2]
     }
    return(answer)
}

fxUSD <- function(fx){
  if(fx[1,] == "AUD"||fx[1,] == "EUR"||fx[1,] == "GBP"||fx[1,] == "NZD"){
    answer = 1/fx[1,2]
  }else{
    answer = fx[1,2]
  }
  return(answer)
}