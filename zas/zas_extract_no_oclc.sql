set linesize 10
-- start and end dates: inclusive dates when records were added/edited
define start_date = &1;
define end_date = &2;

select distinct
  bm.bib_id
from ucladb.bib_master bm
inner join ucladb.bib_mfhd bmd on bm.bib_id = bmd.bib_id
inner join ucladb.mfhd_master mm on bmd.mfhd_id = mm.mfhd_id
inner join ucladb.location l on mm.location_id = l.location_id
inner join ucladb.mfhd_item mi on mm.mfhd_id = mi.mfhd_id -- to ensure at least 1 item exists
inner join ucladb.bib_history bh on bm.bib_id = bh.bib_id
inner join ucladb.mfhd_history mh on mm.mfhd_id = mh.mfhd_id
where (l.location_code = 'sr' or l.location_code LIKE 'srucl%')
and bm.suppress_in_opac = 'N'
and mm.suppress_in_opac = 'N'
and not exists ( select * from ucladb.bib_index where bib_id = bm.bib_id and index_code = '0350' and normal_heading like 'UCOCLC%')
and ( (mh.action_date between to_date('&start_date', 'YYYYMMDD') and to_date('&end_date 235959', 'YYYYMMDD HH24MISS')
        and mh.operator_id != 'nomelvyl'
      )
  or  (bh.action_date between to_date('&start_date', 'YYYYMMDD') and to_date('&end_date 235959', 'YYYYMMDD HH24MISS')
        and bh.operator_id != 'nomelvyl'
      )
)
;
