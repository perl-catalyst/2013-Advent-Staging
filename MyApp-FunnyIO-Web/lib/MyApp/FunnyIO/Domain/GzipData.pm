package MyApp::FunnyIO::Domain::GzipData;
use Moose;
use MooseX::Singleton;
use IO::Compress::Gzip qw/gzip $GzipError/;
use Path::Class::File;
use namespace::sweep;

has content => ( is => 'ro', isa => 'Str', lazy_build => 1 );

has gzipped => ( is => 'ro', reader => 'getData', lazy_build  => 1 );

sub _build_content {
  return Path::Class::File->new( 'data', 'product.json' )->slurp;
}

sub _build_gzipped {
  my $self = shift;

  my $comp;
  gzip( \$self->content, \$comp ) || die "$GzipError";
  return $comp;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
