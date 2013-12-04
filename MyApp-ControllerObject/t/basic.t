use Test::Most;
use HTTP::Request::Common;
use Catalyst::Test 'MyApp';

{
  ok my $http_response = request(GET '/helloworld');
  is $http_response->content, 'Hello world!';
}

{
  ok my $http_response = request(GET '/echo/123');
  is $http_response->content, '123';
}

done_testing;
