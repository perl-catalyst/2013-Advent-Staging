package MyApp::FunnyIO::Web::Model::FunnyIO;
use base 'Catalyst::Model::Factory';

__PACKAGE__->config( class => 'MyApp::FunnyIO::Domain::FunnyIO' );

sub mangle_arguments {
  my ( $self, $args ) = @_;
  return $args->{data};
}

=head1 NAME

MyApp::FunnyIO::Web::Model::FunnyIO - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.


=encoding utf8

=head1 AUTHOR

Neil Lunn

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
