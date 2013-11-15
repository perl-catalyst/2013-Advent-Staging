package MyCatApp::Controller::Root;

use base 'Catalyst::Controller';

sub root : Path('/helloworld') {
  pop->res->body('Hello world!');
}

sub test_post : POST Path('/echo') {
  my ($self, $c) = @_;
  $c->res->body( $c->req->body_parameters->{val} );
}

1;
