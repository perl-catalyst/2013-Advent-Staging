package MyApp::ControllerObject;

use strict;
use warnings;

use Moose::Exporter;
use Import::Into;
use Module::Runtime qw(use_module);

my ($import, $unimport, $init_meta) =
  Moose::Exporter->build_import_methods( also => ['Moose'] );

sub init_meta {
  my ($class, @args) = @_;
  Moose->init_meta( @args, base_class => 'Catalyst::Controller' );
  goto $init_meta if $init_meta;
}

sub import {
  foreach my $importable (shift->importables) {
      use_module($importable)->import::into(scalar caller);
  }

  goto $import;
}

sub importables {
  'Function::Parameters',
  'CatalystX::Syntax::Action',
  'namespace::autoclean',
}

1;
