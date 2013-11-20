use Test::Most;
use Catalyst::Test 'MyApp';
use HTTP::Request::Common qw(GET PUT POST DELETE);

is request(GET '/test')->content, 'GET';
is request(PUT '/test')->content, 'PUT';
is request(POST '/test')->content, 'POST';
is request(DELETE '/test')->content, 'DELETE';

done_testing;
