use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyApp::FunnyIO::Web';
use MyApp::FunnyIO::Web::Controller::TestIO;

ok( request('/testio')->is_success, 'Request should succeed' );
done_testing();
