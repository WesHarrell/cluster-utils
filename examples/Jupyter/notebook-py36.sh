#!/bin/bash

#SBATCH -c 2
#SBATCH --mem=4G
#SBATCH -p sched_mit_sloan_interactive
#SBATCH --time=2-00:00
#SBATCH -o notebook_%A.out

IP=`hostname -i`
PORT=`shuf -i 2000-65000 -n 1`

module load python/3.6.3
module load sloan/python/modules/3.6

$HOME/.local/bin/jupyter notebook --ip=$IP --port=$PORT --no-browser
