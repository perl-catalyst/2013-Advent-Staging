my $psgi_app = sub {
  my $env = shift;
  return sub {
    my $responder = shift;
    my $writer = $responder->(
      [200, [ 
        'Content-Type' => 'text/plain',
        'Content-Length' => '11', ]]);

    $writer->write('Hello');
    $writer->write(' ');
    $writer->write('World');
    $writer->close;
  };
};

