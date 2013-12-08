use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;

my $mech =  Test::WWW::Mechanize::Catalyst->new( 
  catalyst_app => 'MyApp::FunnyIO::Web' );

$mech->get_ok("/funnyio");
$mech->content_contains("product_id");

done_testing();
