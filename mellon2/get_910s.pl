#!/m1/shared/bin/perl -w

use lib "/usr/local/bin/voyager/perl";
use MARC::Batch;
use UCLA_Batch; #for UCLA_Batch::safenext to better handle data errors

my $infile = $ARGV[0];
my $outfile = $ARGV[1];

my $batch = MARC::Batch->new('USMARC', $infile);
open OUT, '>', $outfile;

# 20050526 akohler: turn off strict validation - otherwise, all records after error are lost
$batch->strict_off();

while ($record = UCLA_Batch::safenext($batch)) {
  $f001 = $record->field('001')->data();
  $field = $record->field('910');
  if ($field) {
    $f910 = $field->as_string();
    if ($f910 !~ /MARS/) {
    print "$f001\t$f910\n";
      print OUT "$f001\t$f910\n";
    }
  }
}
close OUT;
exit 0;

