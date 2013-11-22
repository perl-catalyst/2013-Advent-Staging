package MyApp::Web::View::HTML;

use strict;
use warnings;
use base 'Catalyst::View::TT';

__PACKAGE__->config(
  TEMPLATE_EXTENSION => '.html',
  CATALYST_VAR => 'ctx',
);
