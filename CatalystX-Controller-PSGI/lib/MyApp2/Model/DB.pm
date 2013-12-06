package MyApp2::Model::DB;
use strict;
use warnings;

use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config(
    class   => 'Legacy::DB',
    args    => {
        dbspec  => "legacy",
        region  => "en",
    },
);

sub mangle_arguments {
    my ( $self, $args ) = @_;
    return %$args;
}

1;
