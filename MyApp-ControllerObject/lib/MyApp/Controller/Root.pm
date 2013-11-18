package MyApp::Controller::Root;

use MyApp::ControllerObject;

action helloworld : GET Path('/helloworld') {
  $ctx->res->body( $self->generate_helloworld);
}

action echo($arg) : GET Path('/echo') Args(1) {
  $ctx->res->body( $arg );
}

method generate_helloworld {'Hello world!' }

1;
