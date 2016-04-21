#!/bin/sh
. /opt/local/bin/vger_getenv

REPORTSDIR=/m1/incoming/reclamation/ucfta
BASE=${VGER_BASE}/filmntvdb

/opt/local/bin/vger_sqlplus_run ucla_preaddb ucfta_extract

${BASE}/sbin/Pmarcexport -oucfta_extract.mrc -rB -mM -tucfta_extract.out -q

#./ucfta_extract.pl ucfta_extract.mrc elvl_chg.mrc
# manually split into 90K chunks and name appropriately

#./make_label_files

