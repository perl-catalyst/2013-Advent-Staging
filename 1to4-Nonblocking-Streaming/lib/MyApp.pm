package MyApp;

use Catalyst;

__PACKAGE__->config(
  'Model::Timer' => {
    class => 'MyApp::Timer',
    counter => 5});

__PACKAGE__->setup;
