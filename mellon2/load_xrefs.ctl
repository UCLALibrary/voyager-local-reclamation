OPTIONS (SKIP=4)
LOAD DATA
APPEND
INTO TABLE vger_report.mellon_matches
( oclc_number position(1:11)
, bib_id position(16:22)
)

