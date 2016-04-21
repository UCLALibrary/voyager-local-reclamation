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
  $rectype = substr($leader, 6, 1);
  $fld008 = $record->field('008');
  $fld245 = $record->field('245');
  $sfd245h = $fld245->subfield('h');
  if ($sfd245h && $sfd245h =~ /^sound recording/) {
    $sfd245h =~ s/sound recording/[sound recording]/;
    $fld245->update(h => $sfd245h);
    if ($rectype eq 'a') {
      substr($leader, 6, 1) = 'j';
      $record->leader($leader);
      $new008=$fld008->as_string();
      substr($new008, 7, 4) = '||||';
      substr($new008, 15, 20) = '||||||||||||||||||||';
      $fld008->update($new008);
    }
  }
  print OUT $record->as_usmarc();
}
close OUT;

exit 0;

