package MyApp::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' };

__PACKAGE__->config(namespace => '');

sub default: Private {
    my ( $self, $c ) = @_;

    $c->stash(
        leak    => sub {
            return $c;
        }
    );
    $c->res->body('drip');
}

__PACKAGE__->meta->make_immutable;
