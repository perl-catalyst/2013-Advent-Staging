package MyWSApp;

use Web::Simple;

sub dispatch_request {
  sub (GET + /helloworld) {
    [ 200, [ 'Content-type', 'text/plain' ], [ 'Hello world!' ] ]
  },
  sub (POST + /echo + %:val=) {
    [ 200, [ 'Content-type', 'text/plain' ], [ $_{val} ] ]
  },
}

__PACKAGE__->run_if_script;
