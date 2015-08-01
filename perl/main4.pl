use strict;
use warnings;
use Term::Screen;
use Data::Dumper;

use Parser;
use LogCounter;

my $parser = Parser->new( filename => '../sample_data/large_log.ltsv' );

my $counter = LogCounter->new($parser->parse);
my $path =  $counter->group_by_path;
my @path_list = sort(keys($path));
my $scr = Term::Screen->new();

$scr->clrscr()->noecho();

my $path_list_length = $#path_list + 1;
$scr->at(0,0)->puts("Choose path . press q and exit");
sub render {
  my ($pos) = @_;
  my $count = 0;
  for my $p (@path_list) {
    if ($pos == $count) {
      $scr->at($count + 1, 0)->reverse()->puts($p)->normal();
    } else {
      $scr->at($count + 1, 0)->puts($p);
    }
    $count++;
  }
  # print Dumper
  my $status =  LogCounter->new($path->{$path_list[$pos]})->group_by_status;
  $scr->clreos();
  $scr->at($count + 1, 0)->puts("---:     5    10        20");
  for my $stat (sort keys($status)) {
    my $length = @{$status->{$stat}};
    $scr->at($count + 2, 0)->puts("$stat:" . ("=" x $length));
    $count++;
  }
  $scr->at($count + 2, 0);
}

my $ch = '';
render(0);
my $index = 0;

while(($ch = $scr->getch()) ne 'q') {
  if ($ch eq "ku") {
    $index = ($index - 1) % $path_list_length;
  } elsif ($ch eq "kd") {
    $index = ($index + 1) % $path_list_length;
  }
  render($index);
}
