package MyApp::Timer;

use Moose;
use AnyEvent;

has 'writer' => (
  is => 'bare',
  required => 1,
  handles => ['write', 'close']);

has 'counter' => (
  traits => ['Counter'],
  is => 'ro',
  required => 1,
  handles => {
    decrement_counter => 'dec'});

has 'watcher' => (
  is => 'ro',
  lazy_build => 1,
  init_arg => undef,
  clearer => 'clear_watcher');

sub _build_watcher {
  my $self = shift;
  return AnyEvent->timer(
    after => 0,
    interval => 1,
    cb => sub { $self->write_or_finalize } );
}

sub start { shift->watcher }

sub write_or_finalize {
  my $self = shift;
  $self->decrement_counter >= 0 
    ? $self->write_timestamp
      : $self->finalize;
}

sub write_timestamp {
  my $self = shift;
  $self->write(scalar localtime ."\n");
}

sub finalize {
  my $self = shift;
  $self->close;
  $self->clear_watcher;
}

__PACKAGE__->meta->make_immutable;
