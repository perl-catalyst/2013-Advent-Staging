package MyApp::Web;

use Catalyst;
use MyApp::Web::Simple;

__PACKAGE__->config(
  psgi_middleware => [
    'Delegate' => { psgi_app =>
      MyApp::Web::Simple->new(
        app => __PACKAGE__
      )->to_psgi_app },
  ]);

__PACKAGE__->setup;
