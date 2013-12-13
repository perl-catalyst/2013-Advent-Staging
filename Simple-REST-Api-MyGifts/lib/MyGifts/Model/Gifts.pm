package MyGifts::Model::Gifts;

use strict;
use base 'Catalyst::Model';
use List::Util qw/first max/;
use List::MoreUtils qw/first_index/;

my @data = (
  { id => 0, name => 'Car', img => 'http://placekitten.com/200/300', to => 'Joe' },
  { id => 1, name => 'Headphones', img => 'http://placekitten.com/200/300', to => 'Bob' },
  { id => 2, name => 'Snowman', img => 'http://placekitten.com/200/300', to => 'Mike' },
);

# Used for testing
sub _get_data { return @data }

sub all {
  return [ map { id => $_->{id}, name => $_->{name} }, @data ];
}

sub retrieve {
  my ( $self, $id ) = @_;
  return first { $_->{id} == $id } @data;
}

sub add_new {
  my ( $self, $gift_data ) = @_;
  # Verify all fields in place
  return if ! $gift_data->{name} || ! $gift_data->{img};

  my $next_id = max(map $_->{id}, @data) + 1;
  push @data, { %$gift_data, id => $next_id };
  return $#data;
}

sub update {
  my ( $self, $gift_id, $gift_data ) = @_;
  return if ! defined($gift_data->{name}) ||
            ! defined($gift_data->{id})   ||
            ! defined($gift_data->{img});

  my $idx = first_index { $_->{id} == $gift_id } @data;
  return if ! defined($idx);

  $data[$idx] = { %$gift_data, id => $gift_id };
  return 1;
}

sub delete_gift {
  my ( $self, $gift_id ) = @_;
  my $idx = first_index { $_->{id} == $gift_id } @data;

  return if ! defined($idx);

  splice @data, $idx, 1;
}

