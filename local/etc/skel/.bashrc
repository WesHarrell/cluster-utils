# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Default Engaging config
module load gcc
module load slurm

# Sloan config module
module use -a /home/software/sloan/modulefiles
module load sloan/config

# DO NOT CHANGE ANYTHING ABOVE THIS LINE
########################################
#
# Add your configuration below
#
