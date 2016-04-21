set linesize 10;

with clu as (
  select bib_id from vger_report.clu_export_1
  union
  select bib_id from vger_report.clu_export_2
  union
  select bib_id from vger_report.clu_export_3
  union
  select bib_id from vger_report.clu_export_4
  union
  select bib_id from vger_report.clu_export_5
)
select bib_id
from clu
order by bib_id
;

