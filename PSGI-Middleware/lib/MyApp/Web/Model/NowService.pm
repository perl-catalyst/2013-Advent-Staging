package MyApp::Web::Model::NowService;

use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config(
  class => 'MyApp::NowService',
  args => {
    psgi => MyApp::Web::Simple->new(
      app => 'MyApp::Web')->to_psgi_app
  });
