#!/bin/bash
#get Sloan user CPU usage in seconds since STARTTIME
#
if [ -z $1 ]; then
  echo "Please supply a start date in YYYY-MM-DD format, for example:"
  echo "  user-cpu-usage.sh 2016-07-01"
  exit 1
fi
STARTTIME=$1
USERTMP=`mktemp`
CPUTMP=`mktemp`
for i in `showu | grep ^member  | awk '{print $2}' | tee $USERTMP`; do 
  sacct -u $i -S $STARTTIME --format CPUTimeRAW -X | grep [0-9] | awk '{sec+=$1} END {print sec/3600}' >> $CPUTMP
done
paste $USERTMP $CPUTMP >> ~/eo-usage-since-$STARTTIME
rm -f $USERTMP $CPUTMP
echo "Output file: eo-usage-since-$STARTTIME is in your Home directory"
