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

for p in `echo $PROCLIST`; do
  ps a -o ppid,args | grep -i $p | egrep -i -v "($FILTER|$FILTER2|$FILTER3)" | sort -u > $TMPU
  if [[ -f $TMPU ]]; then
    cat $TMPU | while read line
    do
      lppid=`echo $line | cut -d' ' -f1`
      lproc=`echo $line | cut -d' ' -f2-`
      luser=`ps a -o ppid,user | grep $lppid | awk '{print $2}'`

      if [[ "$luser" != "root" ]]; then
        mailx -s "EOSLOAN: $luser is running $lproc" wharrell@mit.edu<<EOM
User: $luser running $lproc on EOSLOAN
EOM

        mailx -s "WARNING: process on Engaging login node" $luser@mit.edu<<EOW

You are running the following process on the Engaging login node:

$lproc

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

      fi
    done
  fi
done

exit 0
