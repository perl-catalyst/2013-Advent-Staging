package MyApp::Controller::Root;

use base 'Catalyst::Controller';

sub time_server :Path(/) {
  my ($self, $c) = @_;
  $c->model('Timer')->start;
}

1;


