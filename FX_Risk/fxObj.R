
######################################################################
# Create Foreign Exchange class
#
# Class fx Object
# 
#**********************************************************************

options(scipen = 999)

setClass("Forex",

         slots = c(
           FxName = "character",
           FxRate = "numeric",
           Baselocal = "numeric",
           BaseUSD = "numeric"
         ),
        
         prototype=list(
           Name = "TWD",
           FxRate = 29.9,
           Baselocal = 29.9,
           BaseUSD = 29.9
         )
)


setGeneric(name="Baselocal",
           def=function(object)
           {
             standardGeneric("Baselocal")
           }
)

setMethod("Baselocal","Forex",
          function(object){
            if(object@FxName == "AUD"||object@FxName == "EUR"||object@FxName == "GBP"||object@FxName == "NZD"){
              object@Baselocal = object@FxRate
            }else{
              object@Baselocal = 1/object@FxRate
            }
            return(object@Baselocal)
          }
)


setGeneric(name="BaseUSD",
           def=function(object)
           {
             standardGeneric("BaseUSD")
           }
)

setMethod("BaseUSD","Forex",
          function(object){
            if(object@FxName == "AUD"||object@FxName == "EUR"||object@FxName == "GBP"||object@FxName == "NZD"){
              object@BaseUSD = 1/object@FxRate
            }else{
              object@BaseUSD = object@FxRate
            }
            return(object@BaseUSD)
          }
)
