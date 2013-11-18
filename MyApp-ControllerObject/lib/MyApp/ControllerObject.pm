package MyApp::ControllerObject;

use strict;
use warnings;

use Moose ();
use Method::Signatures::Simple ();
use CatalystX::Syntax::Action ();
use namespace::autoclean ();
use Sub::Exporter ();
use Moose::Exporter;

my ($import, $unimport, $init_meta) =
  Moose::Exporter->build_import_methods( also => ['Moose'] );

sub init_meta {
  my ($class, @args) = @_;
  Moose->init_meta( @args, base_class => 'MyApp::ControllerObject::_Base' );
  goto $init_meta if $init_meta;
}

sub imports {qw/method_signatures namespace_autoclean syntax_action warnings_and_strict/}

sub import {
  my ($class, @args) = @_;
  my $caller = caller;

  $class->${\"_import_$_"}($caller, @args)
    for $class->imports;

  goto $import;
}

sub _import_warnings_and_strict {
  my ($class, $caller, @args) = @_;

  strict->import;
  warnings->import(FATAL => 'all');
}

sub _import_method_signatures {
  my ($class, $caller, @args) = @_;
  Method::Signatures::Simple->import(
    into => $caller,
  );
}

sub _import_syntax_action {
  my ($class, $caller, @args) = @_;
  CatalystX::Syntax::Action->import(
    into => $caller,
  );
}

sub _import_namespace_autoclean {
  my ($class, $caller, @args) = @_;
  namespace::autoclean->import(
    -cleanee => $caller,
  );
}

package MyApp::ControllerObject::_Base;

use Moose;
extends 'Catalyst::Controller';


__PACKAGE__->config(
  action_roles => ['QueryParameter'],
);

1;

