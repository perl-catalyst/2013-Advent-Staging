use Test::Most;
use HTTP::Request::Common;
use MyApp;

{
  ok my $http_response = MyApp->run_request(GET '/');
  is $http_response->content, 'root path';
}

{
  ok my $http_response = MyApp->run_request(POST '/test-post', [val=>'posted']);
  is $http_response->content, 'posted';
}

{
  ok my $http_response = MyApp->run_request('GET' => '/');
  is $http_response->content, 'root path';
}

{
  ok my $http_response = MyApp->run_request('POST' => '/test-post', {val=>'posted'});
  is $http_response->content, 'posted';
}

{
  ok my $http_response = MyApp->GET('/');
  is $http_response->content, 'root path';
}

{
  ok my $http_response = MyApp->POST('/test-post', {val=>'posted'});
  is $http_response->content, 'posted';
}

done_testing;
