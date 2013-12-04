package MyApp2::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Controller::PSGI' };

__PACKAGE__->config(namespace => '');

use Plack::Response;

use Legacy::App;
use Legacy::DB;

has "_db" => (
    is      => 'ro',
    builder => '_build_db',
    lazy    => 1,
);
sub _build_db {
    my $self = shift;
    return Legacy::DB->new(
        dbspec  => "legacy",
        region  => "en",
    );
}

has "_legacy_app" => (
    is      => "ro",
    builder => "_build_legacy_app",
    lazy    => 1,
);
sub _build_legacy_app {
    my $self = shift;
    return Legacy::App->new(
        db      => $self->_db,
    );
}

my $legacy_app_wrapper = sub {
    my ( $self, $env ) = @_;
    my ( $status, $body ) = $self->_legacy_app->handle_request( $env->{PATH_INFO} );

    my $res = Plack::Response->new( $status );
    $res->content_type('text/html');
    $res->body( $body );

    return $res->finalize;
};

__PACKAGE__->mount( 'some/action'   => $legacy_app_wrapper );
__PACKAGE__->mount( 'foo'           => $legacy_app_wrapper );

sub default: Local{
    my ( $self, $c ) = @_;

    $c->res->body('not found');
    $c->res->status(404);
}

__PACKAGE__->meta->make_immutable;
