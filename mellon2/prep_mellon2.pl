#!/m1/shared/bin/perl -w

use MARC::Batch;
use UCLA_Batch; #for UCLA_Batch::safenext to better handle data errors

if ($#ARGV != 2) {
  print "\nUsage: $0 infile outfile rejectfile\n";
  exit 1;
}

my $infile = $ARGV[0];
my $outfile = $ARGV[1];
my $rejectfile = $ARGV[2];

my $batch = MARC::Batch->new('USMARC', $infile);
open OUT, '>', $outfile;
open REJ, '>', $rejectfile;

# remove these records from file
my %bad_oclcs = (
  'ocm00249847', '',
  'ocm00495164', '',
  'ocm00655927', '',
  'ocm00686012', '',
  'ocm01177745', '',
  'ocm01192383', '',
  'ocm02001248', '',
  'ocm02137169', '',
  'ocm02560078', '',
  'ocm02579802', '',
  'ocm02817067', '',
  'ocm03582718', '',
  'ocm03675720', '',
  'ocm04251603', '',
  'ocm04408228', '',
  'ocm04414858', '',
  'ocm04544584', '',
  'ocm04675914', '',
  'ocm04988695', '',
  'ocm05259912', '',
  'ocm05797360', '',
  'ocm06681762', '',
  'ocm06867265', '',
  'ocm07952704', '',
  'ocm08027846', '',
  'ocm08267590', '',
  'ocm09121276', '',
  'ocm09351893', '',
  'ocm09894276', '',
  'ocm10738081', '',
  'ocm11999363', '',
  'ocm12551494', '',
  'ocm12621185', '',
  'ocm13046069', '',
  'ocm13196509', '',
  'ocm13682009', '',
  'ocm14247892', '',
  'ocm14760457', '',
  'ocm15433974', '',
  'ocm15696714', '',
  'ocm18056081', '',
  'ocm18056120', '',
  'ocm18493823', '',
  'ocm18521194', '',
  'ocm18906812', '',
  'ocm19541769', '',
  'ocm19567017', '',
  'ocm22118236', '',
  'ocm22224965', '',
  'ocm22339171', '',
  'ocm25405812', '',
  'ocm25860427', '',
  'ocm25965080', '',
  'ocm27882671', '',
  'ocm36459156', '',
  'ocm37075085', '',
  'ocm38268741', '',
  'ocm47222532', '',
  'ocm50803855', '',
  'ocm57463798', '',
  'ocm60335744', '',
  'ocm60389441', '',
  'ocm61385833', '',
  'ocm62606103', '',
  'ocm70268561', '',
  'ocm71124679', '',
  'ocn181705343', '',
  'ocn219840866', '',
  'ocn229454227', '',
  'ocn270107597', '',
  'ocn270826970', ''
);

# 20050526 akohler: turn off strict validation - otherwise, all records after error are lost
$batch->strict_off();

while ($record = UCLA_Batch::safenext($batch)) {
  # Get OCLC number 
  $oclc = $record->field('001')->data();
  $oclc =~ s/\s+$//;

  # Reject or update, depending on OCLC number
  if ( exists($bad_oclcs{$oclc}) ) {
    print REJ $record->as_usmarc();
  }
  else {
    # Update 049 (matches only, not unres)
    #$field = $record->field('049');
    #if ($field) {
    #  $field->update('a' => 'VBIB');
    #}
    # New 910
    #$field = MARC::Field->new('910', '', '', 'a' => 'oclcmellon2match');
    $field = MARC::Field->new('910', '', '', 'a' => 'oclcmellon2nomatch');
    $record->insert_fields_ordered($field);
    # Update 994
    $field = $record->field('994');
    if ($field) {
      $field->update('a' => '02');
    }
    print OUT $record->as_usmarc();
  }
}
close OUT;
close REJ;
exit 0;

