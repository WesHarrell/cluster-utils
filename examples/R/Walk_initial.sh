#!/bin/bash

#SBATCH --job-name=Walk_initial
#SBATCH --output=Walk_initial_%a_out.txt
#SBATCH --error=Walk_initial_%a_err.txt
#SBATCH -p sched_any_quicktest
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G

#SBATCH --array=1-5

module load engaging/R/3.2.5
module load sloan/R/CRAN

srun Rscript --quiet --no-restore --no-save Walk_initial.R ${SLURM_ARRAY_TASK_ID}

