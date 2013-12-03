package MyApp::FunnyIO::Domain::FunnyIO;
use Moose;
use IO::Uncompress::Gunzip;
use IO::Scalar;
use namespace::sweep;

use overload
  '-X'  => \&myFileTest;

has '_gunzip' => (
  is        => 'bare',
  isa       => 'IO::Uncompress::Gunzip',
  handles   => [qw/read getline close/]
);

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

  return $class->$orig({
    '_gunzip'   => IO::Uncompress::Gunzip->new( $ref ),
    '_content'  => $ref
  });
};

no Moose;
__PACKAGE__->meta->make_immutable;
1;
