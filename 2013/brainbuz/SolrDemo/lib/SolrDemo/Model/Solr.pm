package SolrDemo::Model::Solr;

use WebService::Solr ;
use WebService::Solr::Query;
use namespace::autoclean;

use parent 'Catalyst::Model::DBI';

use Moose;
    has SOLR=>(
        is => 'ro',
        isa => 'WebService::Solr',
        lazy_build=> 1, );
    sub _build_SOLR {
        my $self = shift ;
        return WebService::Solr->new( SolrDemo->config->{ solrserver } ) ;  }
        ;

1;