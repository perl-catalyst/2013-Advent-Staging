use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyApp::FunnyIO::Web';
use MyApp::FunnyIO::Web::Controller::FunnyIO;

ok( request('/funnyio')->is_success, 'Request should succeed' );
done_testing();
