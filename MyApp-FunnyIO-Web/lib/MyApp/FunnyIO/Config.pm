package MyApp::FunnyIO::Config;

use Config::JFDI;

use Path::Class::File;
use Path::Class::Dir;
use namespace::sweep;

sub config {
  my $path = $INC{'MyApp::FunnIO::Config.pm'};
  my $dir = Path::Class::File->new($path)->dir->relative;

  while ( $dir =~ m/lib/ ) {
    $dir = $dir->parent;
  }

  my $config = Config::JFDI->new(
    name    => 'MyApp::FunnyIO',
    path    => $dir
  );

  return $config->get;

}

1;
