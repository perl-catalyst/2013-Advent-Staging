package MyApp::Controller::Root;

use base 'Catalyst::Controller';

sub as_hashref : POST Path(/as-hashref) {
  my ($self, $c) = @_;
  my $p = $c->req->body_parameters;
  $c->res->body("Name: $p->{name}, Age: $p->{age}");
}

sub as_hashref_obj : POST Path(/as-hashref-obj) {
  my ($self, $c) = @_;
  my $p = $c->req->body_parameters;
  $c->res->body("Name: ${\$p->get('name')}, Age: ${\$p->get('age')}");
}

sub as_all_obj : POST Path(/as-all-obj) {
  my ($self, $c) = @_;
  my $p = $c->req->body_parameters;
  $c->res->body("Name: ${\$p->get('name')}, Age: ${\join '', $p->get_all('age')}");
}

1;
