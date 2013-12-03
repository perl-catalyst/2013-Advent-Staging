package SolrDemo::Model::Solr::Method;

use WebService::Solr::Query;
use namespace::autoclean;
use Moose;
use SolrDemo;

extends 'SolrDemo::Model::Solr';

sub List {
        my $self = shift ;
        SolrDemo->log->info( 'In the Model');
SolrDemo->log->info( 'Server in Config is: ' . SolrDemo->config->{ solrserver } );
#         my $db = $self->db ;
#         my @counties = $db->query('SELECT * FROM county ORDER by county')->flat ;
#         return @counties ;
        }

__PACKAGE__->meta->make_immutable( inline_constructor => 0 );