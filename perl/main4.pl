use strict;
use warnings;

use Data::Dumper;

use Parser;
use LogCounter;

my $parser = Parser->new( filename => '../sample_data/large_log.ltsv' );

my $counter = LogCounter->new($parser->parse);
my $path =  $counter->group_by_path;

for my $p (sort keys($path)) {
  print "$p\n";
  print "---:\n";
  my $status =  LogCounter->new($path->{$p})->group_by_status;
  for my $stat (sort keys($status)) {
    my $count = @{$status->{$stat}};
    print "$stat:" . ("=" x $count) . "\n";
  }
  print "\n";
}
