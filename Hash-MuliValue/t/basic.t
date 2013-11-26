use Test::Most;
use Catalyst::Test 'MyApp';
use HTTP::Request::Common;

{
  ok my $res = request(POST '/as-hashref', [name=>'John', age=>44]);
  is $res->content, 'Name: John, Age: 44';
}

{
  ok my $res = request(POST '/as-hashref', [name=>'John', age=>26, age=>44]);
  is $res->content, 'Name: John, Age: 44';
}

{
  ok my $res = request(POST '/as-hashref-obj', [name=>'John', age=>44]);
  is $res->content, 'Name: John, Age: 44';
}

{
  ok my $res = request(POST '/as-hashref-obj', [name=>'John',age=>26, age=>44]);
  is $res->content, 'Name: John, Age: 44';
}

{
  ok my $res = request(POST '/as-all-obj', [name=>'John',age=>26, age=>44]);
  is $res->content, 'Name: John, Age: 2644';
}

done_testing;
