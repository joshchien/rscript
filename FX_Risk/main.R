
flink <- getwd()
flink <- paste(flink,"/Position/tr_holding_exchange_20181026.csv",sep="")

mydata <- read.table(flink,header = F,quote = "",comment.char = "",sep = "|")

