package MyApp::Controller::Root;

use base 'Catalyst::Controller';

sub streamer :Path(/) {
  my ($self, $c) = @_;
  $c->model('Stream')->start;
}

1;


