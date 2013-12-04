use warnings;
use strict;
use AnyEvent::AIO;
use IO::AIO;

my $read_chunk;
$read_chunk = sub {
  my ($writer, $fh, $offset) = @_;
  my $buffer = '';
  aio_read $fh, $offset, 65536, $buffer, 0, sub {
    my $status = shift;
    die "read error[$status]: $!" unless $status >= 0;
    if($status) {
      $writer->write($buffer);
      $read_chunk->($writer, $fh, ($offset + 65536));
    } else {
      $writer->close;
      aio_close $fh, sub { };
    }
  }
};

my $psgi_app = sub {
  my $env = shift;
  return sub {
    my $responder = shift;
    my $writer = $responder->(
      [200, [ 'Content-Type' => 'text/plain' ]]);

    aio_open 'root/lorem.txt', IO::AIO::O_RDONLY, 0, sub {
      my ($fh) = @_ or die $!;
      $read_chunk->($writer, $fh, 0);
    };
  };
};





