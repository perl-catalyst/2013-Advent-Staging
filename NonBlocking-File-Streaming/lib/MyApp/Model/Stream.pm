package MyApp::Model::Stream;

use Moose;

extends 'Catalyst::Model::Factory';

has 'path' => (is=>'ro', required=>1);


sub prepare_arguments {
  my ($self, $c, $args) = @_;
  return +{ 
    writer => $c->res->write_fh,
    path => $self->path->stringify
  };
}

__PACKAGE__->meta->make_immutable;
