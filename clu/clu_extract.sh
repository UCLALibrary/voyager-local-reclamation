#!/bin/sh
. /opt/local/bin/vger_getenv

REPORTSDIR=/m1/incoming/reclamation/clu
BASE=${VGER_BASE}/ucladb
COUNTER=1
DATE=090328

for LIST in clu_extract.??; do
  NEWNAME=DATA.D${DATE}.FILE${COUNTER}
  COUNTER=`expr ${COUNTER} + 1`
  if [ ${COUNTER} -eq 20 ]; then
    DATE=`expr ${DATE} + 1`
    COUNTER=1
  fi

  ${BASE}/sbin/Pmarcexport -o${NEWNAME} -rB -mM -t${LIST} -q
  
done
