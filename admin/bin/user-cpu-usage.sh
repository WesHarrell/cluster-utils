#!/bin/bash
#get Sloan user CPU usage in seconds since STARTTIME
#
if [ -z $1 ]; then
  echo "Please supply a start date (and optional end date)  in YYYY-MM-DD format, for example:"
  echo "  user-cpu-usage.sh 2016-07-01 2016-09-01"
  exit 1
else
  STARTTIME=$1
fi
if [ -z $2 ]; then
  STOPTIME=`date +%Y-%m-%d`
else
  STOPTIME=$2
fi
#
FOUT="eo-usage-$STARTTIME-$STOPTIME"
if [ -f ~/$FOUT ]; then
  rm -f ~/$FOUT
fi 
for i in `eo-show-users`; do 
  sacct -p -u $i -S $STARTTIME -E $STOPTIME --format User,CPUTimeRAW -X |grep ^[a-z] |awk -F"|" '{sec+=$2} END {print $1"," sec}' |grep -v ^, | tee -a ~/$FOUT
done
echo "Output file: $FOUT is in your Home directory"
