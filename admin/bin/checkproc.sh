#!/bin/bash
#checkproc.sh - This script checks processes on the login
#node.  If users are running applications listsed in $PROCLIST
#they are emailed a warning.  SloanRC members are also alerted.
#The processes in question should be manually terminated.

TMPU=`mktemp`
PROCLIST="exec/R python julia gcc matlab mathematica stata sas"
FILTER="screen |tmux |tail |less |sftp |scp |wget |curl |rsync |nano |vim |vi "
FILTER2="firefox |mozilla |emacs |grep |srun |sbatch |chmod |chgrp |chown "
FILTER3="sublime_text |cat |head |more |view "

mailuser ()
{
mailx -s "WARNING: process on Engaging login node" $1@mit.edu<<EOW

You are running the following process on the Engaging login node:

$2

This has been reported and your process will be terminated.

No jobs or applications should be run from the login node.  ALL jobs must be
submitted with srun or sbatch.

Please read through our documentation for the proper way to run jobs on
the cluster:

https://mysloan.mit.edu/offices/sts/rsrchcomp/Pages/EngagingHPC.aspx

If you believe this email is in error, or you have any questions don't hesitate
to contact us at stshelp@mit.edu

Sloan RC Team

EOW
}

mailadmin ()
{
mailx -s "EOSLOAN: $1 is running $2" wharrell@mit.edu<<EOM
User: $luser running $lproc on EOSLOAN
EOM
}

for p in `echo $PROCLIST`; do
  ps a --no-headers -o ppid:1,args:1 | grep -i $p | egrep -i -v "($FILTER|$FILTER2|$FILTER3)" | sort -u > $TMPU
  if [[ -s $TMPU ]]; then
    cat $TMPU | while read line
    do
      lppid=`echo $line | cut -d' ' -f1`
      lproc=`echo $line | cut -d' ' -f2-`
      luser=`ps a --no-headers -o ppid:1,user:1 | grep $lppid | grep -v root | awk '{print $2}'`
      mailadmin $luser $lproc
      mailuser $luser $lproc
    done
  fi
done

#rm -f $TMPU

exit 0
