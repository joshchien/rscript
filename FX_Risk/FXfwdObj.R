
######################################################################
# Create Forex class
#
# Class ForexForward

options(scipen = 999)

ForexForward <- setClass(
  # Set the name for the class
  "ForexForward",
  # Define the slots
  slots = c(
    Name = "character",
    TDate = "Date",
    EndDate = "Date",
    BuyCury = "character",
    BuyAmt = "numeric",
    SellCury = "character",
    SellAmt = "numeric",
    Strike = "numeric",
    NetNotional = "numeric",
    Tau = "numeric",
    THEOFwd = "numeric",
    THEOValue = "numeric",
    MtM_Org = "numeric"
  ),
  # Set the default values for the slots. (optional)
  prototype=list(
    Name = "FXName",
    TDate = as.Date("2018-11-29"),
    EndDate = as.Date("2019-01-22"),
    BuyCury = "USD",
    BuyAmt = 100000000,
    SellCury = "TWD",
    SellAmt = 2893900000
  ),
  # Make a function that can test to see if the data is consistent.
  # This is not called if you have an initialize function defined!
  validity=function(object)
  {
    if(is.numeric(object@BuyAmt)==FALSE||is.numeric(object@SellAmt)==FALSE){
      return("Not numeric was given.")
    }
    if(is.character(object@BuyCury)==FALSE||is.character(object@SellCury)==FALSE){
      return("Not String was given.")
    }
      return(TRUE)
  }
)

# Create method for ForexForward Obj
# ****************************************************************************
# The basic idea is that if the name of a function has not been defined, 
# the name must first be reserved using the setGeneric function. 
# The setMethod can then be used to define which function is called based 
# on the class names of the objects sent to it.
# ****************************************************************************

setGeneric(name="Strike",
           def=function(object)
           {
             standardGeneric("Strike")
           }
)

# Find Strike Function ////////
setMethod("Strike","ForexForward",
    function(object){
        if(object@SellCury=="USD"){
            if(object@BuyCury == "AUD" || object@BuyCury == "NZD"||object@BuyCury == "GBP"||object@BuyCury == "EUR"){
              strike = 1/(object@SellAmt/object@BuyAmt)
            }else{
              strike = object@BuyAmt/object@SellAmt
            }
        }else{
          if(object@SellCury == "AUD" || object@SellCury == "NZD"||object@SellCury == "GBP"||object@SellCury == "EUR"){
              strike = 1/(object@BuyAmt/object@SellAmt)
          }else{
              strike = object@SellAmt/object@BuyAmt
          }
        }
      object@Strike = strike
      return(strike)
    }
)
# Find Net Notional Function for short/long USD Position ////////
setGeneric(name="NetNotional",
           def=function(object)
           {
             standardGeneric("NetNotional")
           }
)

setMethod("NetNotional","ForexForward",
      function(object){
        if(object@BuyCury != "USD"){
          object@NetNotional = -object@SellAmt
        }else{
          object@NetNotional = object@BuyAmt
        }
        return(object@NetNotional)
      }
)

# Find days to maturity Function ////////
setGeneric(name="TermLength",
           def=function(object)
           {
             standardGeneric("TermLength")
           }
)
setMethod("TermLength","ForexForward",
          function(object){
            object@Tau = as.numeric(object@EndDate) - as.numeric(object@TDate)
            return(object@Tau)
          }
)

# Theo Forward Rate Function ////////
setGeneric(name="THEOFwd",
           def=function(object,fxUSD,DFUSD,DFLocal)
           {
             standardGeneric("THEOFwd")
           }
)
setMethod("THEOFwd","ForexForward",
          function(object,fxUSD,DFUSD,DFLocal){
            THEOFwd = fxUSD * DFUSD / DFLocal
            object@THEOFwd = THEOFwd
            return(THEOFwd)
          }
)

# Theo Value Function ////////
setGeneric(name="THEOValue",
           def=function(object,DFLocal)
           {
             standardGeneric("THEOValue")
           }
)
setMethod("THEOValue","ForexForward",
          function(object,DFLocal){
            object@THEOValue = (object@THEOFwd - object@Strike) * DFLocal
            return(object@THEOValue)
          }
)

# MtM Function ////////
setGeneric(name="MtM",
           def=function(object)
           {
             standardGeneric("MtM")
           }
)
setMethod("MtM","ForexForward",
          function(object){
            object@MtM_Org = object@THEOValue * object@NetNotional 
            return(object@MtM_Org)
          }
)