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
my @all_data = MyGifts::Model::Gifts->new->_get_data;

my $response = get '/gifts';

my @gifts = @{from_json($response)->{data}};
is(@gifts, @all_data, "gift count match");

for ( my $i=0 ; $i < @all_data; $i++ ) {
  is(keys %{$gifts[$i]}, 2, "[$i] has 2 data fields");
  is($gifts[$i]->{name}, $all_data[$i]->{name}, "[$i] name match");
  is($gifts[$i]->{id}, $all_data[$i]->{id}, "[$i] id match");
}

done_testing();

