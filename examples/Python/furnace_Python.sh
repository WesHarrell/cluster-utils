#!/bin/bash

#SBATCH --job-name=furnace_Python
#SBATCH --output=furnace_Python_out.txt
#SBATCH --error=furnace_Python_err.txt
#SBATCH -p sched_any_quicktest
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000

module load engaging/python/2.7.10
module load sloan/python/2.7-modules

srun xvfb-run python < furnace_Python.py
