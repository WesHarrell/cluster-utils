#!/bin/bash
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=2G
#SBATCH --partition=sched_mit_sloan_batch
#SBATCH --time=3-12:00
#SBATCH -o /home/my-kerberos-username/project1.out
#SBATCH -e /home/my-kerberos-username/project1.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=me@email.com

module load python/3.6.3

python3 project1.py
