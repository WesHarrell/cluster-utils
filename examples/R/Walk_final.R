# asymmetric random walk with reflection at 0 (Lindley process)

f <- function(job.id) readRDS(paste("Walk",job.id,".rds",sep=''))

vec <- t(sapply(1:5, f))

cat('Average of earlier job outputs','\n'); cat('\n'); 

cat('Mean', '\n')
mu <- mean(vec[,1]); mu

cat('\n'); cat('Standard deviation','\n')  
sigma <- sqrt(mean(vec[,2])-mu^2); sigma 
























