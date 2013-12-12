use strict;
use warnings;

use SolrDemo;

my $app = SolrDemo->apply_default_middlewares(SolrDemo->psgi_app);
$app;

