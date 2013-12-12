package MyApp;
use Moose;

use Catalyst;

__PACKAGE__->config(
    'psgi_middleware', [
        'Debug' => {panels => [qw/DBITrace Memory Timer CatalystStash CatalystLog/]},
    ],
);

__PACKAGE__->setup;
