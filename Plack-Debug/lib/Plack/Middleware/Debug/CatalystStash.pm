package Plack::Middleware::Debug::CatalystStash;
use 5.008;
use strict;
use warnings;
use parent qw(Plack::Middleware::Debug::Base);

use Class::Method::Modifiers qw(install_modifier);
use Data::Dumper;
use HTML::Entities qw/encode_entities_numeric/;

our $VERSION = '0.001';

install_modifier 'Catalyst', 'before', 'finalize' => sub {
    my $c = shift;

    local $Data::Dumper::Terse = 1;
    local $Data::Dumper::Indent = 1;
    local $Data::Dumper::Deparse = 1;
    $c->req->env->{'plack.middleware.catalyst_stash'} =
        encode_entities_numeric( Dumper( $c->stash ) );
};

sub run {
    my($self, $env, $panel) = @_;

    return sub {
        my $res = shift;

        my $stash = delete $env->{'plack.middleware.catalyst_stash'} || 'No Stash';
        $panel->content("<pre>$stash</pre>");
    };
}

1;
