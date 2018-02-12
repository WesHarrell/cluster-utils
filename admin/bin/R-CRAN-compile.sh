#!/bin/bash
#
MODPATH=/home/software/sloan/modulefiles/sloan/R
LIBPATH=/home/software/sloan/local/lib/R
CRANBUILD=/home/wharrell/git/engaging/admin/bin/R-CRAN-compile.R
ROUT=/nfs/sloanlab001/projects/sloanrc_proj/tmp
#
if [[ $# -lt 2 || $1 = -h || $1 = --help ]]; then
  echo ""
  echo "Build CRAN"
  echo ""
  echo "Usage: R-CRAN-compile.sh <CRAN-Repo-Version> <R-Env-Module-Path>"
  echo "   Eg: R-CRAN-compile.sh 3.4 R/3.4.2"
  echo ""
  exit 1
fi

if [[ ! -e $MODPATH/$1/CRAN ]]; then
  echo "The modulefile $MODPATH/$1/CRAN does not exist, please create"
  exit 1
elif [[ ! -d $LIBPATH/$1 ]]; then
  echo "The library path $LIBPATH/$1 does not exist, please create"
  exit 1
else
  echo "Loading Modules..."
fi

module load $2
module load sloan/R/$1/CRAN
module load engaging/jdk/1.8.0-91
module load engaging/jre/1.8.0-91
module load engaging/OpenBLAS/0.2.14
module load scalapack/gcc/64/1.8.0
module load engaging/gurobi/7.5.0
module load engaging/sqlite/3.13.0
module load netcdf/gcc/64/4.3.1.1
module load engaging/gdal/2.0.2
module load engaging/JAGS/4.2.0
module load sloan/texinfo
module load sloan/texlive
module load openmpi/2.1.1
module load cuda/8.0
module load cudnn/6.0

echo "Did you receive any module load errors? (y|n)"
read reply

if [[ $reply = "y" ]]; then
  echo "Fix module load errors, exiting..."
  exit 1
fi

[[ ! -d $HOME/tmp ]] && mkdir $HOME/tmp

echo "Submitting job to build CRAN, check CRAN-build logfiles"
echo "in $ROUT for any specific log or error information."

sbatch -c 8 --mem=64G --gres=gpu:1 -p sched_mit_thesmar --time=3-00:00 \
  -o $ROUT/CRAN-build.out -e $ROUT/CRAN-build.err \
  --mail-type=BEGIN,END,FAIL --mail-user=sts.rc@mit.edu -J CRAN-build \
  xvfb-run R CMD BATCH --vanilla "--args $1" $CRANBUILD $ROUT/CRAN-build.Rout

  #xvfb-run R CMD BATCH --vanilla "--args $1" /home/wharrell/Test/R/printargs.R \
