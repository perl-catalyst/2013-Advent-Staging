package Legacy::App;
use strict;
use warnings;

sub new {
    my $class = shift;
    my %config = @_;

    return bless \%config, $class;
}

sub handle_request {
    my ( $self, $url ) = @_;

    my $content = $self->{db}->load_page( $url );
    return ( 404, 'not found' ) if !defined $content;

    return ( 200, $content );
}

1;
