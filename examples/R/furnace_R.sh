#!/bin/bash

#SBATCH --job-name=furnace_R
#SBATCH --output=furnace_R_out.txt
#SBATCH --error=furnace_R_err.txt
#SBATCH -p sched_any_quicktest
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000

module load engaging/R/3.2.5
module load sloan/R/CRAN

# srun R --quiet --no-restore --no-save < furnace.R
# replace “R” by “Rscript” and remove the redirect:

srun Rscript --quiet --no-restore --no-save furnace.R

# but need to insert
#
# library(methods)
# library(grDevices)
#
# at the top of the R program

# http://stackoverflow.com/questions/19468506/rscript-could-not-find-function


