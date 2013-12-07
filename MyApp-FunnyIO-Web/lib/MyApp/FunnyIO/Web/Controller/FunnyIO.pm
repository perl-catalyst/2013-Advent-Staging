package MyApp::FunnyIO::Web::Controller::FunnyIO;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyApp::FunnyIO::Web::Controller::FunnyIO - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  my ( $body, $comp );

  $comp = $c->model('GzipData')->getData();

  $c->res->content_type('text/plain');

  if ( defined($c->req->header('accept-encoding')) &&
      ($c->req->header('accept-encoding') =~ /gzip/ )) {
    $c->log->debug( 'Sending compressed' );
    $c->res->content_encoding('gzip');
    $body = $comp;
  } else {
    $c->log->debug( 'Sending uncompressed' );
    $body = $c->model('FunnyIO', data => \$comp);
  }

  $c->res->body( $body );

}

sub end : Private {} # No views in this controller


=encoding utf8

=head1 AUTHOR

Neil Lunn

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
