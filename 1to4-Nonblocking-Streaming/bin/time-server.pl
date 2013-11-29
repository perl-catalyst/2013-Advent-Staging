use AnyEvent;

my $psgi_app = sub {
  my $env = shift;
  return sub {
    my $responder = shift;
    my $writer = $responder->(
      [200, [ 'Content-Type' => 'text/plain' ]]);

   my $watcher;
   $watcher = AnyEvent->timer(
    after => 1,
    interval => 1,
    cb => sub {
      $writer->write("Finishing: ${\scalar localtime}\n", $watcher);
      #undef $watcher; # cancel circular-ref

    });
    
  };
}
