package MyApp::Web::Simple;

use Web::Simple;

has 'app' => (is=>'ro', required=>1);

sub render_hello {
  my ($self, $where) = @_;
  return $self->app->view('HTML')->render($self->app,
    'hello.html', {where=>'web-simple'} );
}

sub dispatch_request {
  my $self = shift;
  sub (/websimple-hello) {
    [ 200, [ 'Content-type', 'text/html' ],
      [$self->render_hello]
    ],
  },
}

1;
