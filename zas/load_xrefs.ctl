OPTIONS (SKIP=1)
LOAD DATA
TRUNCATE
INTO TABLE vger_report.zas_matches
FIELDS TERMINATED BY x'09'
( oclc_number
, bib_id
)

