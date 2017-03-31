# asymmetric random walk with reflection at 0 (Lindley process)

library(rslurm)

rnd_W <- function(k)
  {
    W <- t(sapply(1:40, function(o)
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
    c(mean(W), mean(W^2)) 
  }

pars <- data.frame(k = 1:500)

sjob <- slurm_apply(rnd_W, pars, jobname = "test_W", nodes = 250,
                    slurm_options = list("cpus-per-task" = "1", "mem" = "2G"))

saveRDS(sjob, file = "sjobW.rds")    

