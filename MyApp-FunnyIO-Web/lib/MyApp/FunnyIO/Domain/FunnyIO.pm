package MyApp::FunnyIO::Domain::FunnyIO;
use Moose;
use MooseX::NonMoose::InsideOut;
extends 'IO::Uncompress::Gunzip';
use IO::Scalar;
use namespace::sweep;

use overload
  'bool'  => sub {1},
  '-X'    => \&myFileTest;

has '_content' => ( is => 'ro' );

sub myFileTest {
  my ( $self, $arg ) = @_;

  if ( $arg eq "s" ) {

    my $io = IO::Scalar->new( $self->_content );
    $io->seek( -4, 2 );
    $io->read(  my $buf, 4 );
    return unpack( 'V', $buf );

  } else {
    die "Only implementing a size operator at this time";
  }

}

around BUILDARGS => sub {
  my ( $orig, $class, $ref ) = @_;
  return $class->$orig({ '_content' => $ref });
};


sub FOREIGNBUILDARGS {
  my ( $class, $args ) = @_;
  return $args;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
