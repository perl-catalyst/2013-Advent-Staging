use MyApp;
use MyApp::Stream;

{
  package MockWriter;
  use Test::Most;

  sub new { bless {lines=>[]}, shift }

  sub write {
    my ($self, $line) = @_;
    push @{$self->{lines}}, $line;
  }

  sub close {
    my ($self) = @_;
    ok 1;
    ok @{$self->{lines}};
    done_testing;
  }
}

my $mocker = MockWriter->new;
my $streamer = MyApp::Stream->new(
  path => MyApp->path_to('root','lorem.txt')->stringify,
  writer => $mocker);

$streamer->start;

