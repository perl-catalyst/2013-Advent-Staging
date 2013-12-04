use Test::Most;
use Catalyst::Test 'MyApp';
use HTTP::Request::Common;
use JSON::MaybeXS;
 
{
  ok my $req = POST '/echo',
     Content_Type => 'application/json',
     Content => encode_json +{message=>'test'};
 
  ok my $res = request $req;
 
  is $res->content, 'test', 'Handles JSON post';
}
 
{
  ok my $req = POST '/echo', [message=>'test'];
  ok my $res = request $req;
 
  is $res->content, 'test', 'Handles classic HTML post';
}

done_testing;
