my $psgi_app = sub {
  my $env = shift;
  return sub {
    my $responder = shift;
    my $writer = $responder->(
      [200, [ 'Content-Type' => 'text/plain' ]]);

    while(1) {
      $writer->write(scalar localtime);
      sleep 1;
    }

  };
};

