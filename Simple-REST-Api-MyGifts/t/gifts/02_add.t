#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use JSON;

use Catalyst::Test 'MyGifts';
use HTTP::Request::Common;
use Test::Deep;
use MyGifts::Model::Gifts;
use List::MoreUtils qw/any/;
##########
# Test adding a new gift
#

my $new_gift = { name => 'TV', img => '/my/tv.png', to => 'me' };

# Request to add $new_gift
my $response = request POST '/gifts',
                        Content_Type => 'application/json',
                        Content => to_json($new_gift);


my $new_item_url = $response->header('Location');

# Read new item info
my $new_item_from_server = from_json(get $new_item_url)->{data};

# Make sure the new item is what we put in there
cmp_deeply($new_item_from_server, { %$new_gift, id => ignore() });

# Get all items list
my @all_gifts = @{ from_json(get '/gifts')->{data} };
my $needle = { name => $new_gift->{name}, id => $new_item_from_server->{id} };

# Make sure our new item is in the list
ok( any { eq_deeply($_ , $needle) } @all_gifts, 'New item in list');

done_testing();
