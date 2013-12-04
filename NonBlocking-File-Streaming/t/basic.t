use Test::Most;
use HTTP::Request::Common;
use Catalyst::Test 'MyApp';

{
  ok my $http_response = request(GET '/');
  ok $http_response->content, 'Has content';
}

done_testing;
