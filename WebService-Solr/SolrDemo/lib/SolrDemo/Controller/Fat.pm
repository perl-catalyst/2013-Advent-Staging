package SolrDemo::Controller::Fat;
use namespace::autoclean;
use WebService::Solr::Query;
use Moose;

BEGIN { extends 'Catalyst::Controller' }

sub realquery : Local : Args(2) {
    my ( $self, $c, $fieldname, $fieldvalue ) = @_;
    my @docs = $c->model('Solr')->List( { $fieldname => $fieldvalue } );
    $c->stash(
        template  => 'results.tt',
        field     => $fieldname,
        value     => $fieldvalue,
        docs      => \@docs,
    );
}

sub nearkimmel : Local : Args() {
    my ( $self, $c ) = @_;
    my $distance = 1600;
    my @docs     = $c->model('Solr')->Kimmel( $distance );
    $c->stash(
        template  => 'results.tt',
        field     => 'Distance from Kimmel Center in Philadelphia',
        value     => $distance,
        docs      => \@docs,
    );
}

__PACKAGE__->meta->make_immutable;

1;

=head1 AUTHOR

brainbuz,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
