package MyApp::Controller::Root;

use base 'Catalyst::Controller';

sub as_json : POST Path('/echo') 
 Consumes('application/json') {
  my ($self, $c) = @_;
  $c->response->body(
    $c->request->body_data->{message});

}

sub formdata : POST Path('/echo')
 Consumes('application/x-www-form-urlencoded') {
  my ($self, $c) = @_;
  $c->response->body(
    $c->request->body_parameters->{message});
}

1;
