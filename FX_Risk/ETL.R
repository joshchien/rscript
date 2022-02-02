#**********************************************
#
# 
#**********************************************
options(scipen = 999)
TDate <- '20181029'
# Including FX Sepc and FX Spot/Forward market data
lcal_dirpath <- getwd()

#*********************************************************************************
dirpath <- paste(lcal_dirpath,"/MarketData/","FX_spot_",TDate,".csv",sep="")
fx.dat <- read.csv(dirpath,header=T,sep=",",stringsAsFactors = F) ###

dirpath <- paste(lcal_dirpath,"/MarketData/","IR_DF_NDF_CCS_",TDate,".csv",sep="")
fwd.dat <- read.csv(dirpath,header=T,sep=",",stringsAsFactors = F) ###

dirpath <- paste(lcal_dirpath,"/MarketData/",TDate,"_FXValueDate",".csv",sep="")
valuedate <- read.csv(dirpath,header=T,sep=",",stringsAsFactors = F) ###
valuedate$Instrument.ID <- substr(valuedate$Instrument.ID,1,3)
rownames(valuedate) <- valuedate$Instrument.ID

#*********************************************************************************
# 
dirpath <- paste(lcal_dirpath,"/cfg/MarketDataStructure_FX_spot.csv",sep="")
fx.spot <- read.csv(dirpath,header=T,sep=",",stringsAsFactors =F) ###
names(fx.dat)[2] <- names(fx.spot)[2] # Create Primary key as merge function
primky1 <- names(fx.spot)[2]

dirpath <- paste(lcal_dirpath,"/cfg/MarketDataStructure_IR_DF_NDF_CCS.csv",sep="")
fwd.point <- read.csv(dirpath,header=T,sep=",",stringsAsFactors =F) ###
names(fwd.dat)[2] <- names(fwd.point)[1] # Create Primary key as merge function
primky2 <- names(fwd.point)[1]

# Creat fx spot list
fx.tbl <- merge(fx.spot,fx.dat,by=primky1)
fx.tbl<-unique( fx.tbl[ , 1:dim(fx.tbl)[2] ] )
fx.tbl <- data.frame(fx.tbl$FXName,fx.tbl$Mid.Price,fx.tbl$DayCount)
colnames(fx.tbl) <- c("FXName","Spot","DayC")
rownames(fx.tbl) <- fx.tbl$FXName

# Creat fx forward rate spot list
fwd.tbl <- merge(fwd.point,fwd.dat,by= primky2)
rownames(fwd.tbl) <- fwd.tbl$Instrument

# save fx.spot
dirpath <- paste(lcal_dirpath,"/log/FX_spot.csv.log",sep="")
write.csv(fx.tbl,dirpath)
dirpath <- paste(lcal_dirpath,"/log/FX_Forward.csv.log",sep="")
write.csv(fwd.tbl[,c(1,5:8)],dirpath)

#*******************************************************************

# Build Curve 


