package MyApp::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Controller::PSGI' };

__PACKAGE__->config(namespace => '');

use Plack::Util;

has 'legacy_app' => (
    is      => 'ro',
    builder => '_build_legacy_app',
);

sub _build_legacy_app {
    return Plack::Util::load_psgi( MyApp->path_to("bin/legacy.psgi") );
}

sub call {
    my ( $self, $env ) = @_;

    $self->legacy_app->( $env );
}

__PACKAGE__->meta->make_immutable;
