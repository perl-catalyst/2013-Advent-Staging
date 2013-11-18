package MyApp::Controller::Root;

use MyApp::ControllerObject;

has 'test_attribute' => (
  is=>'ro',
  default=>'example value');

method generate_helloworld { 'Hello world!' }

action helloworld : GET Path('/helloworld') {
  $ctx->res->body( $self->generate_helloworld);
}

action echo($arg) : GET Path('/echo') Args(1) {
  $ctx->res->body( $arg );
}

1;
