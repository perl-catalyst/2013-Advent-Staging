package SolrDemo::Model::Solr::Fat;

use WebService::Solr::Query;
use namespace::autoclean;
use SolrDemo;

use Moose;
extends 'SolrDemo::Model::Solr';


sub List {
        my $self = shift ;
        my $params = shift ;
        my $mainquery = WebService::Solr::Query->new( $params ) ;
        my %options = ( rows => 100 ) ;
        my $SOLR = $WebService::Solr::Query::SOLR ;
        my $response = $SOLR->search( $mainquery, \%options );
        return $response->docs ;
        }

__PACKAGE__->meta->make_immutable( inline_constructor => 0 );