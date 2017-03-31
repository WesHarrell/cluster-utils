#!/bin/bash

#SBATCH --job-name=W_final

#SBATCH --output=W_final_out.txt
#SBATCH --error=W_final_err.txt
#SBATCH --ntasks=1

module load engaging/R/3.2.5
module load sloan/R/CRAN

salloc --cpus-per-task=1 --mem=4G -p sched_mit_sloan

Rscript --quiet --no-restore --no-save W_final.R

