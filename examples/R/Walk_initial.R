# asymmetric random walk with reflection at 0 (Lindley process)

args <- commandArgs(TRUE)
job.id <- strtoi(args[1], base=10L)

rnd.Walk <- function(j)
  {
    t(sapply(1:j, function(o)
    {
       N <- 10^6
       p <- 1/3
       X <- 2*rbinom(N,1,p)-1      # X = 1 with probability p
       s <- 0                      # X =-1 with probability 1-p
       m <- 0
       for (t in 1:N)
       {
         s <- max(0,s+X[t])
         m <- max(m,s)
       }
       m
    })) 
  }

cat('Job ID is', job.id, '\n'); cat('\n'); cat('Data', '\n')
W <- rnd.Walk(40); W

cat('\n'); cat('Mean', '\n')
mu1 <- mean(W); mu1

cat('\n'); cat('Mean Square','\n')  
mu2 <- mean(W^2); mu2  

saveRDS(c(mu1, mu2), file = paste("Walk",job.id,".rds",sep=''))


