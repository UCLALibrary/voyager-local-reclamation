set linesize 10;

select distinct
  bm.bib_id
from ethnodb.bib_master bm
inner join ethnodb.bib_mfhd bmd on bm.bib_id = bmd.bib_id
inner join ethnodb.mfhd_master mm on bmd.mfhd_id = mm.mfhd_id
where bm.suppress_in_opac = 'N'
and mm.suppress_in_opac = 'N'
order by bm.bib_id
;

