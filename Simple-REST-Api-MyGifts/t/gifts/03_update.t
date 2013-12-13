#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use JSON;

use Catalyst::Test 'MyGifts';
use HTTP::Request::Common;
use Test::Deep;
use MyGifts::Model::Gifts;

##########
# Test initial gift list includes all the gifts
#
my @gifts = @{from_json(get '/gifts')->{data}};
my $first = shift @gifts;
my $item_url = '/gifts/' . $first->{id};

my $to_update = from_json(get $item_url)->{data};

$to_update->{name} = 'new name';
$to_update->{img} = 'new image';

# Send update request for item
request POST '/gifts/' . $to_update->{id},
        Content_Type => 'application/json',
        Content => to_json($to_update);

# Read item info after update
my $after_update = from_json(get $item_url)->{data};

# Make sure our changes are stored
is($after_update->{name}, 'new name', 'new name match');
is($after_update->{img}, 'new image', 'new image match');


done_testing();


