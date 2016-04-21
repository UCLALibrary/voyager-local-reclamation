set linesize 10;

select distinct
  bm.bib_id
from filmntvdb.bib_master bm
inner join filmntvdb.bib_mfhd bmd on bm.bib_id = bmd.bib_id
inner join filmntvdb.mfhd_master mm on bmd.mfhd_id = mm.mfhd_id
where bm.suppress_in_opac = 'N'
and mm.suppress_in_opac = 'N'
order by bm.bib_id
;

