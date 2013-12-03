package MyApp::FunnyIO::Web::Controller::TestIO;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

use IO::Compress::Gzip qw/gzip $GzipError/;
use IO::Uncompress::Gunzip;
use Data::Dumper;

=head1 NAME

MyApp::FunnyIO::Web::Controller::TestIO - Catalyst Controller

=head1 DESCRIPTION

Example return of 

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  my $data = "123456780ABCDEFGHIJKL";
  my ( $comp, $body );

  gzip(\$data, \$comp) || die $GzipError;

  $c->res->content_type('text/plain');

  if ( $c->req->header('accept_encoding') =~ /gzip/ ) {
    $c->log->debug( 'Sending Compressed' );
    $c->res->content_encoding('gzip');
    $body = $comp;
  } else {
    $c->log->debug( 'Sending Uncompressed' );
    $body = IO::Uncompress::Guzip->new( \$comp );
    #my $length = $body->getHeaderInfo->{ISIZE}; # Hmmn, may not work
    
    # Unpack the last 4 bytes of the compressed data
    my $io = IO::Scalar->new( \$comp );
    $io->seek( -4, 2 );
    $io->read( my $buf, 4 );
    $io->close();
    my $size = unpack( 'V', $buf );

    # Explicitly setting the size
    $c->res->content_length( $size );
  }

  # Returning the body
  $c->res->body( $body );

}

sub end : Private {}  # Don't need template rendering on this controller


=encoding utf8

=head1 AUTHOR

Neil Lunn

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
