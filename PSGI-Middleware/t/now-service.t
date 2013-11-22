use Test::Most;
use MyApp::Web;
use MyApp::Web::Simple;
use MyApp::NowService;

ok my $service = MyApp::NowService
  ->new(psgi => MyApp::Web::Simple
    ->new(app => 'MyApp::Web')
      ->to_psgi_app);

ok $service->now;

done_testing;

