#!/m1/shared/bin/perl -w

use MARC::Batch;

if ($#ARGV != 1) {
  print "\nUsage: $0 infile outfile\n";
  exit 1;
}

my $infile = $ARGV[0];
my $outfile = $ARGV[1];

my $batch = MARC::Batch->new('USMARC', $infile);
open OUT, '>:utf8', $outfile;

# 20050526 akohler: turn off strict validation - otherwise, all records after error are lost
$batch->strict_off();

while ($record = $batch->next()) {
  $leader = $record->leader();
  $elvl = substr($leader, 17, 1);
  if ($elvl eq '1') {
    substr($leader, 17, 1) = '3';
    $record->leader($leader);
  }
  print OUT $record->as_usmarc();
}
close OUT;

exit 0;

