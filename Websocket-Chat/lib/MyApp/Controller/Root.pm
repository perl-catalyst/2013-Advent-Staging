package MyApp::Controller::Root;

use Moose;
use MooseX::MethodAttributes;
use AnyEvent::Handle;
use Protocol::WebSocket::Handshake::Server;
use Protocol::WebSocket::Frame;
use JSON;

extends 'Catalyst::Controller';

has 'history' => (
  is => 'bare',
  traits => ['Array'],
  isa  => 'ArrayRef[HashRef]',
  default => sub { +[] },
  handles => {
    history => 'elements',
    add_to_history => 'push'});

has 'clients' => (
  is => 'bare',
  traits => ['Array'],
  default => sub { +[] },
  handles => {
    clients => 'elements',
    add_client => 'push'});


sub index :Path(/) {
  my ($self, $c) = @_;
  (my $url = $c->uri_for_action($self->action_for('ws')))
    ->scheme('ws');

  $c->stash(websocket_url => $url);
  $c->forward($c->view('HTML'));
}

sub ws :Path(/ws) {
  my ($self, $ctx) = @_;
  my $hs = Protocol::WebSocket::Handshake::Server->new_from_psgi($ctx->req->env);
  my $hd = AnyEvent::Handle->new(
    fh => $ctx->req->io_fh,
    on_error => sub { warn "Error ".pop });

  $hs->parse($hd->fh);
  $hd->push_write($hs->to_string);
  $hd->on_read(sub {
    (my $frame = $hs->build_frame)->append($_[0]->rbuf);
    while (my $message = $frame->next) {
      my $decoded = decode_json $message;
      if(my $user = $decoded->{new}) {
        $decoded = {username=>$user, message=>"Joined!"};
        foreach my $item ($self->history) {
          $hd->push_write(
            $hs->build_frame(buffer=>encode_json($item))
              ->to_bytes);
        }            
      } 

      $self->add_to_history($decoded);
      foreach my $client($self->clients) {
        $client->push_write(
          $hs->build_frame(buffer=>encode_json($decoded))
            ->to_bytes);
      }
    }
  });

  $self->add_client($hd);
}

__PACKAGE__->meta->make_immutable;
__PACKAGE__->config( namespace => '');
