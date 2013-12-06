package MyApp2::Model::LegacyApp;
use strict;
use warnings;

use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config(
    class   => 'Legacy::App',
);

sub prepare_arguments {
    my ( $self, $app ) = @_;

    # this is fine as long as DB doesn't change, if it does you should use
    # Catalyst::Model::Factory::PerRequest
    return {
        db  => $app->model('DB'),
    };
}

sub mangle_arguments {
    my ( $self, $args ) = @_;
    return %$args;
}

1;
