package Parser;
use strict;
use warnings;
use Log;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub parse {
  my $self = shift;
  open my $fh, '<', $self->{filename} or die $!;
  my @lines = <$fh>;
  return [map {
    chomp($_);
    Log->new(map {
       split(/:/, $_, 2);
    } grep {
      $_ !~ /:-$/
    } split(/\t/, $_));
  } @lines];
}

1;
