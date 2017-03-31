#!/bin/bash

#SBATCH --job-name=Walk_final
#SBATCH --output=Walk_final_out.txt
#SBATCH --error=Walk_final_err.txt
#SBATCH -p sched_any_quicktest
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G

module load engaging/R/3.2.5
module load sloan/R/CRAN

srun Rscript --quiet --no-restore --no-save Walk_final.R

