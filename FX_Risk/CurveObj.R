

options(scipen = 999)

setClass("Curves",
         
         slots = c(
           FxName = "character",
           Tau = "numeric",
           Rate = "numeric"
         ),
         
         prototype=list(
           FxName = "TWD",
           Tau = 29.9,
           Rate = 29.9
         )
)
