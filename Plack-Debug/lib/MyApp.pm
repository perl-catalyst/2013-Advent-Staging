package MyApp;
use Moose;

use Catalyst;

__PACKAGE__->config(
    'psgi_middleware', [
        'Debug' => {panels => [
            'Memory',
            'Timer',
            'CatalystLog',
            'CatalystStash',
        ]},
    ],
);

__PACKAGE__->setup;
