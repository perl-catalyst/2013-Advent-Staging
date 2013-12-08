use Test::More;
use IO::Compress::Gzip qw/gzip $GzipError/;

BEGIN { use_ok( 'MyApp::FunnyIO::Domain::FunnyIO' ) };
my $data = "12345367890ABCDEFGHIJKL";
my $comp;
gzip(\$data, \$comp) || die $GzipError;

my $io = new_ok ( 'MyApp::FunnyIO::Domain::FunnyIO', [\$comp] );

can_ok( $io, 'read');
can_ok( $io, 'getline' );
is( -s $io, 23, "Got uncompressed length");
is( $io->getline, $data, "Match uncompressed data");

done_testing();
