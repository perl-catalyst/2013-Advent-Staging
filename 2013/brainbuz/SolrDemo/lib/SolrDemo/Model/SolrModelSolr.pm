package SolrDemo::Model::SolrModelSolr;

use WebService::Solr ;
use WebService::Solr::Query;
use namespace::autoclean;
use Catalyst::Model::WebService::Solr;
use Moose;
    
extends 'Catalyst::Model::WebService::Solr';
    
__PACKAGE__->config(
        server  => SolrDemo->config->{ solrserver },
        options => {
            autocommit => 1,
        }
);



1;