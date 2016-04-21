set linesize 10;

select
  distinct bt.bib_id
from location l
inner join mfhd_master mm on l.location_id = mm.location_id
inner join bib_mfhd bm on mm.mfhd_id = bm.mfhd_id
inner join bib_text bt on bm.bib_id = bt.bib_id
inner join bib_master bms on bm.bib_id = bms.bib_id
where l.location_code in ('yrspbcbc', 'yrspeip', 'yrspeip*', 'yrspeip**', 'yrspback')
and bms.create_date < to_date('20080101', 'YYYYMMDD')
and bms.suppress_in_opac = 'N'
and bt.pub_place is not null
and bt.bib_format like '%m'
and not exists (
  select * 
  from ucladb.bib_index 
  where bib_id = bt.bib_id 
  and index_code = '0350' 
  and normal_heading like 'OCOLC%'
)
and not exists (
  select * 
  from vger_subfields.ucladb_bib_subfield
  where record_id = bt.bib_id
  and tag = '910a'
  and subfield like '%3lvl%'
)
order by bt.bib_id
;

