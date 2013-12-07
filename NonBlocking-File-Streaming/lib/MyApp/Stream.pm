package MyApp::Stream;

use Moose;
use AnyEvent::AIO;
use IO::AIO;
use Try::Tiny;

has 'writer' => (
  is => 'bare',
  required => 1,
  handles => ['write', 'close']);


has 'path' => (is=>'ro', required=>1);

sub start { 
  my ($self) = @_;
  aio_open $self->path, IO::AIO::O_RDONLY, 0, sub {
    my ($fh) = @_ or die "${\$self->path}: $!";
    $self->read_chunk($fh, 0);
  };
}

sub read_chunk {
  my ($self, $fh, $offset) = @_;
  my $buffer = '';
  aio_read $fh, $offset, 65536, $buffer, 0, sub {
    my $status = shift;
    die "read error[$status]: $!" unless $status >= 0;
    if($status) {
      try {
        $self->write($buffer);
      } catch {
        warn $_;
      };
      $self->read_chunk($fh, ($offset + 65536));
    } else {
      $self->close;
      aio_close $fh, sub { };
    }
  }
}

__PACKAGE__->meta->make_immutable;
