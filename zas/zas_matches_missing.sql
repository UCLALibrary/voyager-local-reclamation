-- 1) xref records no longer in Voyager: report to Sara Layne for cleanup
set linesize 30
-- column headings wanted, but only once, so use large pagesize
set heading on
set pagesize 50000
-- This query rarely has results so add a bit of text to remind us what this is
prompt ZAS XREF record(s) no longer in Voyager

select
  bib_id , oclc_number
--  count(*)
from vger_report.zas_matches zm
where not exists (
  select *
  from ucladb.bib_master
  where bib_id = zm.bib_id
)
order by bib_id
;
