package MyApp;

use Catalyst;

__PACKAGE__->config(
  'Model::Stream' => {
    class => 'MyApp::Stream',
    path => __PACKAGE__->path_to('root','lorem.txt') });

__PACKAGE__->setup;
