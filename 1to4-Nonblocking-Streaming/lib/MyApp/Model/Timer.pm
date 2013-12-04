package MyApp::Model::Timer;

use Moose;

extends 'Catalyst::Model::Factory';

has 'counter' => (is=>'ro', isa=>'Num', required=>1);

sub prepare_arguments {
  my ($self, $c, $args) = @_;
  return +{ 
    writer => $c->res->write_fh,
    counter => $self->counter};
}

__PACKAGE__->meta->make_immutable;
