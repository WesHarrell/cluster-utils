#!/bin/bash
#SBATCH --job-name=furnace_SAS
#SBATCH --output=furnace_SAS_out.txt
#SBATCH --error=furnace_SAS_err.txt
#SBATCH -p sched_any_quicktest
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000
module load engaging/sas/9.4
srun xvfb-run sas -noterminal furnace.sas -filelocks none -work /nobackup1/sfinch
