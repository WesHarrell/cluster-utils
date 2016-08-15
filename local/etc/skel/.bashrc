# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
module load gcc
module load slurm 

# Sloan config module
module use -a /home/software/sloan/modulefiles
module load sloan/config
