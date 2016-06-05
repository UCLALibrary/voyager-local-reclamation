#!/bin/sh
. /usr/local/bin/vger_getenv

REPORTSDIR=/m1/incoming/reclamation/cleth
BASE=${VGER_BASE}/ethnodb

/usr/local/bin/vger_sqlplus_run ucla_preaddb cleth_extract

${BASE}/sbin/Pmarcexport -ocleth_extract.mrc -rB -mM -tcleth_extract.out -q

./cleth_extract.pl cleth_extract.mrc DATA.D090415

./make_label_files

