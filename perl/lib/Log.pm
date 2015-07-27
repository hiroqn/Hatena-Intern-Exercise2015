package Log;
use strict;
use warnings;
use Time::Piece;

sub new {
    my ($class, %args) = @_;
    # @args{qw(method path protocol)} =  split(/ /, $args{req});
    # $args{uri} = "http://$args{'host'}$args{'path'}";
    # $args{time} = gmtime($args{'epoch'})->strftime('%FT%T');
    return bless \%args, $class;
}

sub protocol {
    my $self = shift;
    my ($method, $path, $protocol) = split(/ /, $self->{req});
    return $protocol;
}

sub method {
    my $self = shift;
    my ($method, $path, $protocol) = split(/ /, $self->{req});
    return $method;
}

sub path {
    my $self = shift;
    my ($method, $path, $protocol) = split(/ /, $self->{req});
    return $path;
}

sub uri {
    my $self = shift;
    return "http://" . $self->{host} . path $self;
}

sub time {
    my $self = shift;
    return gmtime($self->{epoch})->strftime('%FT%T');;
}

sub to_hash {
    my $self = shift;
    my %hash = map {
       $self->{$_} ? ($_, $self->{$_}) : ();
    } ('status', 'time', 'size', 'uri', 'user', 'method', 'referer');
    return \%hash;
}

1;
