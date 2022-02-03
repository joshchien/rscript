

LineInterpo<-  function(myrange, mydays) {
  
  myrange = as.matrix(myrange)	
  DataNo = length(myrange)
  N = DataNo / 2 -1
  x <- rep(0,N)
  s <-  rep(0,N)
  
  for( i in 1:N){
    x[i] = myrange[i,1]
    s[i] = myrange[i,2]
  }
  
#------------------------------------------  
  if (mydays <= x[1]) {
    LineInterpo = (s[2] * x[1] - s[2] * mydays + s[1] * mydays - s[1] * x[2]) / (x[1] - x[2])
    return(LineInterpo)
  }else if (mydays >= x[N]) {
    LineInterpo = (s[N] * x[N - 1] - s[N] * mydays - s[N - 1] * x[N] + s[N - 1] * mydays) / (x[N - 1] - x[N])
    return(LineInterpo)
  } else {
    j = 1
    while( j <= N - 1){
      if ( mydays >= x[j]  && mydays <= x[j + 1] ) {
        LineInterpo = s[j] + ((s[j + 1] - s[j]) / (x[j + 1] - x[j])) * (mydays - x[j])
        return(LineInterpo)
      }else {
        j = j + 1
      }
    }
  }
}