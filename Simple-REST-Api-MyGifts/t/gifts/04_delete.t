#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use JSON;

use Catalyst::Test 'MyGifts';
use HTTP::Request::Common qw/DELETE GET POST/;
use Test::Deep;
use MyGifts::Model::Gifts;
use List::MoreUtils qw/none/;

my @gifts = @{from_json(get '/gifts')->{data}};
my $item = shift @gifts;
my $item_url = '/gifts/' . $item->{id};

# Delete an item
request DELETE $item_url;

# Item id is no longer in the list
@gifts = @{from_json(get '/gifts')->{data}};
ok( none { $_->{id} == $item->{id} } @gifts);

# Request for the item returns an error
my $res = request GET $item_url;
ok(! $res->is_success, 'fail to get deleted item' );
done_testing();



