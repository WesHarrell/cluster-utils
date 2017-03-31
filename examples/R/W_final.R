library(rslurm)

sjob <- readRDS("sjobW.rds")

res <- get_slurm_out(sjob, outtype = "table")

cat('Average of earlier job outputs','\n'); cat('\n');

cat('Mean', '\n')
mu <- mean(na.omit(res[,1]))
mu

cat('\n'); cat('Standard deviation','\n')  
sigma <- sqrt(mean(na.omit(res[,2])) - mu^2)
sigma

cleanup_files(sjob)    #remove "_rslurm_test_W" folder

