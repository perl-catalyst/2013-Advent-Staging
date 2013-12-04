use HTTP::Request::Common;
use Test::Most;
use Test::Lib;
use MyWSApp;

{
  ok my $http_response = MyWSApp->run_test_request(GET '/helloworld');
  is $http_response->content, 'Hello world!';
}

{
  ok my $http_response = MyWSApp->run_test_request(POST '/echo', [val=>'posted']);
  is $http_response->content, 'posted';
}

{
  ok my $http_response = MyWSApp->run_test_request('GET' => '/helloworld');
  is $http_response->content, 'Hello world!';
}

{
  ok my $http_response = MyWSApp->run_test_request('POST' => '/echo', {val=>'posted'});
  is $http_response->content, 'posted';
}

done_testing;
