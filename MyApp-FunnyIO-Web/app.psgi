#!/usr/bin/env perl
use strict;
use warnings;

use MyApp::FunnyIO::Web;

use Log::Log4perl::Catalyst;
use Plack::Builder;

builder {

  my $app = MyApp::FunnyIO::Web->new;

  $app->log(
    Log::Log4perl::Catalyst->new(
      $app->config->{log}, autoflush => 1
    )
  );

  enable 'Plack::Middleware::BufferedStreaming';
  enable 'Plack::Middleware::ReverseProxy';

  $app->apply_default_middlewares( $app->psgi_app );

}
