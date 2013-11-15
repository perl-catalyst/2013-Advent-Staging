package MyApp::Controller::Root;

use base 'Catalyst::Controller';

sub root : Path('/') {
  pop->res->body('root path');
}

sub test_post : POST Path('/test-post') {
  my ($self, $c) = @_;
  $c->res->body( $c->req->body_parameters->{val} );
}

1;
