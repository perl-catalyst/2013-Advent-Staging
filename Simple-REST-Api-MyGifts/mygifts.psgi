use strict;
use warnings;

use MyGifts;

my $app = MyGifts->apply_default_middlewares(MyGifts->psgi_app);
$app;

