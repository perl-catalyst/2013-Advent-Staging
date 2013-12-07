use strict;
use warnings;
use Test::More;
use Path::Class::File;

use IO::Uncompress::Gunzip qw/gunzip $GunzipError/;

BEGIN { use_ok( 'MyApp::FunnyIO::Domain::GzipData' ) };

my $comp = new_ok( 'MyApp::FunnyIO::Domain::GzipData' );

can_ok( $comp, 'getData' );

my $file = Path::Class::File->new( 'data', 'product.json' )->slurp;
$a = $comp->getData;
my $out;
gunzip( \$a, \$out) || die $GunzipError;

is( $out, $file, "uncompressed content matches" );

done_testing();
