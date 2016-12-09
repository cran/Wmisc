## ------------------------------------------------------------------------
library(Wmisc)
library(microbenchmark)

## ------------------------------------------------------------------------
s <- "You think water moves fast? You should see ice. It moves like it has a mind. Like it knows it killed the world once and got a taste for murder. After the avalanche, it took us a week to climb out. Now, I don't know exactly when we turned on each other, but I know that seven of us survived the slide... and only five made it out. Now we took an oath, that I'm breaking now. We said we'd say it was the snow that killed the other two, but it wasn't. Nature is lethal but it doesn't hold a candle to man."

## ------------------------------------------------------------------------
strHead(s)
strHeadLower(s)
strTail(s)

## ------------------------------------------------------------------------
substr(s,1,1)
tolower(substr(s,1,1))
substring(s,2)

## ------------------------------------------------------------------------
microbenchmark(substr(s,1,1),strHead(s),times=100000)
microbenchmark(tolower(substr(s,1,1)),strHeadLower(s),times=100000)
microbenchmark(substring(s,2),strTail(s),times=100000)

## ------------------------------------------------------------------------
substr(s,1,42)
strTake(s,42)

## ------------------------------------------------------------------------
substring(s,43)
strDrop(s,42)

## ------------------------------------------------------------------------
microbenchmark(substr(s,1,42),strTake(s,42),times=100000)
microbenchmark(substring(s,43),strDrop(s,42),times=100000)

