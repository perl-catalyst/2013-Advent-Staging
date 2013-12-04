package SolrDemo::Model::Solr;

use WebService::Solr;
use WebService::Solr::Query;
use namespace::autoclean;

use parent 'Catalyst::Model';

our $SOLR = WebService::Solr->new( SolrDemo->config->{solrserver} );

sub _GeoFilter {
    my ( $location, $sfield, $distance ) = @_;
    return qq/\{!geofilt pt=$location sfield=$sfield d=$distance\}/;
}

sub List {
    my $self      = shift;
    my $params    = shift;
    my $mainquery = WebService::Solr::Query->new($params);
    my %options   = ( rows => 100 );
    my $response  = $SOLR->search( $mainquery, \%options );
    return $response->docs;
}

sub Kimmel {
    my $self         = shift;
    my $distance     = shift;
    my $kimmelcenter = '39.95,-75.16';
    my $mainquery    = WebService::Solr::Query->new( { '*' => \'*' } );
    my $geofilt      = &_GeoFilter( $kimmelcenter, 'store', $distance );
    my %options      = ( rows => 100, fq => $geofilt );
    my $response     = $SOLR->search( $mainquery, \%options );
    return $response->docs;
}

1;
