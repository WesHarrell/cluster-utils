#!/bin/bash

#SBATCH --job-name=furnace_Stata
#SBATCH --output=furnace_Stata_out.txt
#SBATCH --error=furnace_Stata_err.txt
#SBATCH -p sched_any_quicktest
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000

module load engaging/stata-se/14

srun stata-se < furnace_Stata.do
