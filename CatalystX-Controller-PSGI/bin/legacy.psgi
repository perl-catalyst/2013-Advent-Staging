use strict;
use warnings;
use Plack::Response;

use Legacy::App;
use Legacy::DB;

my $db = Legacy::DB->new(
    dbspec  => "legacy",
    region  => "en",
);

my $legacy_app = Legacy::App->new(
    db      => $db,
);

my $app = sub {
    my ( $env ) = @_;

    my ( $status, $body );
    if ( $env->{PATH_INFO} eq 'some/action' ) {
       ( $status, $body ) = $legacy_app->handle_request( $env->{PATH_INFO} );
    }
    elsif ( $env->{PATH_INFO} eq 'some/other/action' ) {
       ( $status, $body ) = $legacy_app->handle_request( $env->{PATH_INFO} );
    }
    elsif ( $env->{PATH_INFO} eq 'foo' ) {
       ( $status, $body ) = $legacy_app->handle_request( $env->{PATH_INFO} );
    }
    else {
        $status = 404;
        $body = 'not found';
    }

    my $res = Plack::Response->new( $status );
    $res->content_type('text/html');
    $res->body( $body );

    return $res->finalize;
};

$app;
