package MyApp::Controller::Some;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Controller::PSGI' };

sub other_action: Path('other/action') {
    my ( $self, $c ) = @_;

    $c->res->body("WOOO CATALYST");
}

__PACKAGE__->meta->make_immutable;
