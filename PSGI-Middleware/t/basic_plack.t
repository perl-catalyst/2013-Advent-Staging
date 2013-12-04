use Test::Most;
use Plack::Test;
use HTTP::Request::Common;

use MyApp::Web;
use MyApp::Web::Simple;

ok my $app = MyApp::Web::Simple->new(app => 'MyApp::Web')
  ->to_psgi_app;

test_psgi $app, sub {
    my $cb  = shift;
    my $ws_res = $cb->(GET '/websimple-hello');
    is($ws_res->code, '200', '200 response');
    like($ws_res->content, qr/web-simple/, 'response content');
};

done_testing;

