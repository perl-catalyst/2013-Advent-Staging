use Test::Most;
use Catalyst::Test 'MyApp::Web';

ok( get('/catalyst-hello') =~ /Catalyst/ );
ok( get('/websimple-hello') =~ /web-simple/ );

done_testing;

