package LogCounter;
use strict;
use warnings;

sub new {
    my ($class, $logs) = @_;
    return bless { logs => $logs }, $class;
};

sub group_by_user {
  my $self = shift;
  my %hash;
  foreach my $log (@{$self->{logs}}) {
    my $user = $log->{user} ? $log->{user} : 'guest';
    if (exists($hash{$user})) {
      push $hash{$user}, $log;
    } else {
      $hash{$user} = [$log];
    }
  }
  return \%hash;
}

sub count_error {
  my $self = shift;
  my @tmp = grep {
    $_->{status} >= 500 && $_->{status} < 600;
  } @{$self->{logs}};
  return $#tmp + 1;
}

sub group_by_path {
  my $self = shift;
  my %hash;
  foreach my $log (@{$self->{logs}}) {
    my $path = $log->path;
    if (exists($hash{$path})) {
      push $hash{$path}, $log;
    } else {
      $hash{$path} = [$log];
    }
  }
  return \%hash;
}

sub group_by_status {
  my $self = shift;
  my %hash;
  foreach my $log (@{$self->{logs}}) {
    my $status = $log->{status};
    if (exists($hash{$status})) {
      push $hash{$status}, $log;
    } else {
      $hash{$status} = [$log];
    }
  }
  return \%hash;
}

1;
