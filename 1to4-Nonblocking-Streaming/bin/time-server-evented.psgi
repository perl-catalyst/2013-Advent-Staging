use AnyEvent;
use warnings;
use strict;

my $watcher;
my $timer_model = sub {
  my $writer = shift;
  $watcher = AnyEvent->timer(
    after => 0,
    interval => 1,
    cb => sub {
      $writer->write(scalar localtime ."\n");
    });
};

my $psgi_app = sub {
  my $env = shift;
  return sub {
    my $responder = shift;
    my $writer = $responder->(
      [200, [ 'Content-Type' => 'text/plain' ]]);

    $timer_model->($writer);
    
  };
};
