#!/bin/bash

#SBATCH --job-name=93cars_R
#SBATCH --output=93cars_R_out.txt
#SBATCH --error=93cars_R_err.txt
#SBATCH -p sched_any_quicktest
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000

module load engaging/R/3.2.5
module load sloan/R/CRAN

# srun R --quiet --no-restore --no-save < 93cars.R
# replace “R” by “Rscript” and remove the redirect:

srun Rscript --quiet --no-restore --no-save 93cars.R

