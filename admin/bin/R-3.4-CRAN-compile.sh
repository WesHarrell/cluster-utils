#!/bin/bash
#
#SBATCH -c 8
#SBATCH --mem=32G
#SBATCH -p sched_mit_sloan_interactive
#SBATCH --time=2-12:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=sts.rc@mit.edu
#SBATCH -J CRAN-compile

module load R/3.4.2
module load sloan/R/3.4/CRAN
##
module load engaging/jdk/1.8.0-91
module load engaging/jre/1.8.0-91
module load engaging/openmpi
module load engaging/OpenBLAS/0.2.14
module load scalapack/gcc/64/1.8.0
module load engaging/gurobi/7.0.1
module load engaging/sqlite/3.13.0
module load netcdf/gcc/64/4.3.1.1
module load harvard/centos6/cairo-1.12.14
module load engaging/gdal/2.0.2
module load engaging/JAGS/4.2.0
module load sloan/texinfo
module load sloan/texlive

xvfb-run R --vanilla < /home/software/sloan/admin/bin/R-3.4-CRAN-compile.R
