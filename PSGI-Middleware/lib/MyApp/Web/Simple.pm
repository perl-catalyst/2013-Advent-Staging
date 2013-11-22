package MyApp::Web::Simple;

use JSON;
use Web::Simple;

has 'app' => (is=>'ro', required=>1);

sub render_hello {
  my ($self, $where) = @_;
  return $self->app->view('HTML')->render($self->app,
    'hello.html', {where=>'web-simple'} );
}

sub render_now { encode_json {now => scalar(localtime)} }

sub dispatch_request {
  my $self = shift;
  sub (/websimple-hello) {
    [ 200, [ 'Content-type', 'text/html' ],
      [$self->render_hello]
    ],
  },
  sub (/now) {
    [ 200, [ 'Content-type', 'application/json' ],
      [$self->render_now],
    ]  
  },
}

1;
