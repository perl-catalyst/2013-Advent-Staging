use strict;
use warnings;
use Plack::Response;

#let's pretend this is a legacy app wrapped in plack...
my $app = sub {
    my ( $env ) = @_;

    #ugly, but it'll prove our point, which is all that matters
    my $status = 200;
    my $body;
    if ( $env->{PATH_INFO} eq 'some/action' ) {
        $body = "this is some/action";
    }
    elsif ( $env->{PATH_INFO} eq 'some/other/action' ) {
        $body = "this is some/other/action";
    }
    elsif ( $env->{PATH_INFO} eq 'foo' ) {
        $body = "this is foo";
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
