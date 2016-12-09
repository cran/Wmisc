## ------------------------------------------------------------------------
library(Wmisc)

## ------------------------------------------------------------------------
M <- Automat$new()

## ------------------------------------------------------------------------
M$addTransition("beans available","button pressed","ground coffee",function(s,i,t){
  "grinding coffee"
})
M$addTransition("ground coffee","heat water","water heated",function(s,i,t){
  "heating water"
})
M$addTransition("water heated","brew coffee","coffee ready",function(s,i,t){
  "brewing coffee"
})
M$addTransition("coffee ready","take coffee","beans available",function(s,i,t){
  "enjoy your coffee"
})

M

## ---- fig.show='hold'----------------------------------------------------
M$visualize()

## ---- fig.show='hold'----------------------------------------------------
M$setState("beans available")
M
M$visualize()

## ------------------------------------------------------------------------
M$read("button pressed")
M$read("heat water")
M$read("brew coffee")
M$read("take coffee")

## ------------------------------------------------------------------------
Queue <- R6::R6Class("Queue",
                      public = list(
                        pop = function(){
                          r <- private$q[1]
                          private$q<-private$q[-1]
                          r
                        },
                        push = function(e){
                          private$q<-c(e,private$q)
                        },
                        append = function(e){
                          private$q<-c(private$q,e)
                        },
                        length = function(){
                          length(private$q)
                        }
                      ),
                      private = list(q=c())
                    )

## ------------------------------------------------------------------------
q <- Queue$new()
M <- Automat$new()

M$addTransition("beans available","button pressed","ground coffee",function(s,i,t){
   q$push("heat water")
   "grinding coffee"
})
M$addTransition("ground coffee","heat water","water heated",function(s,i,t){
  q$push("brew coffee")
  "heating water"
})
M$addTransition("water heated","brew coffee","coffee ready",function(s,i,t){
  "brewing coffee"
})
M$addTransition("coffee ready","take coffee","beans available",function(s,i,t){
"enjoy your coffee"
})

M$setState("beans available")
q$append("button pressed")
q$append("take coffee")

while (q$length() > 0){
  print(M$read(q$pop()))
}


## ------------------------------------------------------------------------
M <- Automat$new()

M$addTransition("empty","fill beans","no water")
M$addTransition("empty","fill water","no beans")
M$addTransition("empty",NA,"empty",function(s,i,t){          # (1)
  print(paste0("'", i, "': that does not help, still ", t))
  return()
})

M$addTransition("no water","fill water","ready")
M$addTransition("no beans","fill beans","ready")

M$setPredicate("no beans",function(i){                       # (2)
  if (grepl("fill beans|coffee",i)){
    return("fill beans")
  }
  return(i)
})

M$addTransition("ready","press button","coffee ready",function(s,i,t){
  print("grinding coffee")                                   # (3)
  print("heating water")
  print("brewing coffee")
  print("please take your coffee")
  return()
})

M$addTransition("coffee ready","take coffee","ready",function(s,i,t){
  print("enjoy your coffee")
  return()
})

M$addTransition(NA,"clean machine","empty")                  # (4)
M$addTransition(NA,NA,"awaiting service",function(s,i,t){    # (5)
  print(paste0("Thou shall not ",i," in state (",s,").\nPlease clean the machine."))
  return()
})         

M$addTransition(NA,NA,NA,function(s,i,t){                    # (6)
  print(paste0("Log: (",s,",",i,",",t,")"))
})         

M$setState("empty")

## ---- fig.show='hold', fig.cap = "The Machine."--------------------------
M$visualize()


## ------------------------------------------------------------------------
M$read("fill tea")
M$read("fill water")
M$read("fill coffee")
M$read("press button")
M$read("take coffee")
M$read("press button")
M$read("press button")
M$read("fill coffee")
M$read("clean machine")
M$read("fill beans")
M$read("fill water")

