package Legacy::DB;
use strict;
use warnings;

sub new {
    my $class = shift;
    my %config = @_;

    return bless \%config, $class;
}

sub load_page {
    my ( $self, $url ) = @_;

    return $self->{dbspec} . ':' . $self->{region} . ':' . $url;
}

1;
