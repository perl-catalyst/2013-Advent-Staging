package MyApp::NowService;

use Moo;
use HTTP::Message::PSGI;
use HTTP::Request;
use HTTP::Response;
use JSON;

has 'psgi' => (is=>'ro', required=>1);

sub now {
  my ($self) = @_;
  my $request = HTTP::Request->new(GET => '/now');
  my $response = HTTP::Response->from_psgi(
    $self->psgi->($request->to_psgi));

  return decode_json($response->content)->{now};
}

__PACKAGE__->meta->make_immutable;
