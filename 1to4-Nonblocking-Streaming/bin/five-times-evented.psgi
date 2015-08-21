use AnyEvent;
use warnings;
use strict;

my $timer_model = sub {
  my $writer = shift;
  my $count = 1;
  my $timer;
  $timer = AnyEvent->timer(
    after => 0,
    interval => 1,
    cb => sub {
      $writer->write(scalar localtime ."\n");
      if(++$count > 5) {
        $writer->close;
        # this cancels the timer, and breaks a circular reference
        undef $timer;
      }
    });
};

my $psgi_app = sub {
  my $env = shift;
  return sub {
    my $responder = shift;
    my $writer = $responder->(
      [200, [ 'Content-Type' => 'text/plain' ]]);

    $timer_model->($writer);
    # our timer lives on via a circular reference.
    # return value is ignored
  };
};
