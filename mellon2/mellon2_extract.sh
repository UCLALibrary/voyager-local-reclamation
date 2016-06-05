#!/bin/sh
. /usr/local/bin/vger_getenv

REPORTSDIR=/m1/incoming/reclamation/mellon1
BASE=${VGER_BASE}/ucladb

/usr/local/bin/vger_sqlplus_run ucla_preaddb mellon1_extract

${BASE}/sbin/Pmarcexport -omellon1_extract.mrc -rB -mM -tmellon1_extract.out -q

mv mellon1_extract.mrc DATA.D090615

./make_label_files

