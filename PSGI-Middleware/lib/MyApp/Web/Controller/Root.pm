package MyApp::Web::Controller::Root;
 
use Moose;
use MooseX::MethodAttributes;

extends 'Catalyst::Controller';

sub start : Chained('/')
 PathPrefix CaptureArgs(0)
{
  my ($self, $ctx) = @_;
}

  sub hello : Chained('start')
   PathPart('catalyst-hello') Args(0)
  {
    my ($self, $ctx) = @_;
    $ctx->stash(where=>'Catalyst');
    $ctx->forward($ctx->view('HTML'));
  }

  sub now : Chained('start')
    PathPart('catalyst-now') Args(0)
  {
    my ($self, $ctx) = @_;
    my $now = $ctx->model('NowService')->now;
    $ctx->stash(now=>$now);
    $ctx->forward($ctx->view('HTML'));
  }

__PACKAGE__->config(namespace => '' );
__PACKAGE__->meta->make_immutable;

