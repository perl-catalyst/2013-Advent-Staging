package MyApp2::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Controller::PSGI' };

__PACKAGE__->config(namespace => '');

use Plack::Response;

with 'Catalyst::Component::InstancePerContext';

has 'c' => (
    is  => 'rw',
);

sub build_per_context_instance {
    my ( $self, $c ) = @_;

    return $self->new(
        %{ $self->config },
        c => $c,
    );
}

my $legacy_app_wrapper = sub {
    my ( $self, $env ) = @_;
    my ( $status, $body ) = $self->c->model('LegacyApp')->handle_request( $env->{PATH_INFO} );

    my $res = Plack::Response->new( $status );
    $res->content_type('text/html');
    $res->body( $body );

    return $res->finalize;
};

__PACKAGE__->mount( 'some/action'   => $legacy_app_wrapper );
__PACKAGE__->mount( 'foo'           => $legacy_app_wrapper );

sub default: Private {
    my ( $self, $c ) = @_;

    $c->res->body('not found');
    $c->res->status(404);
}

__PACKAGE__->meta->make_immutable;
