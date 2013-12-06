use strict;
use warnings;
use FindBin qw($Bin);

use lib "${Bin}/lib";

use MyApp2;
my $app = MyApp2->apply_default_middlewares( MyApp2->psgi_app );

$app;
