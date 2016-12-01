#!/bin/bash

#SBATCH --job-name=furnace_Matlab
#SBATCH --output=furnace_Matlab_out.txt
#SBATCH --error=furnace_Matlab_err.txt
#SBATCH -p sched_any_quicktest
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000

module load mit/matlab/2016a

srun matlab < furnace_Matlab.m
