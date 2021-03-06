#!/bin/bash

#SBATCH -c 2
#SBATCH --mem=4G
#SBATCH -p sched_mit_sloan_interactive
#SBATCH --time=2-00:00
#SBATCH -o notebook_%A.out

IP=`hostname -i`
PORT=`shuf -i 2000-65000 -n 1`

$HOME/anaconda3/bin/jupyter notebook --ip=$IP --port=$PORT --no-browser
