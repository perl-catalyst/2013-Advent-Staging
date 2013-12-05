package SolrDemo::Model::Solr;

use WebService::Solr;
use WebService::Solr::Query;
use namespace::autoclean;
use WebService::Solr::Field ;
use WebService::Solr::Document ;
#use Carp::Always;

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

sub Delete {
    my $self      = shift;
    my $params    = shift;
    # If the query isn't forcibly stringified an exception may be thrown.
    my $query = sprintf( "%s", WebService::Solr::Query->new($params) );
    my $result = $SOLR->delete_by_query( $query ) ;    
 #   $SOLR->commit() ;
    return $result ;
}

=pod
my @fields = (
    [ id     => 1,               { boost => 1.6 } ],
    [ sku    => 'A6B9A',         { boost => '1.0' } ],
    [ manu   => 'The Bird Book', { boost => '7.1' } ],
    [ weight => '4.0',           { boost => 3.2 } ],
    [ name   => 'Sally Jesse Raphael' ],
);
=cut

sub Add {
    my $self      = shift;
    my $params    = shift;
    my $boost     = shift;
    my @fields_array = () ;
    foreach my $k ( keys %{$params} ) { 
			my @fields = ( $k, $params->{ $k } );
			if ( $boost->{ $k } ) { 
					push @fields, ( { boost => $boost->{ $k } } ) } 
			push @fields_array, ( \@fields ) ;
		}
	my $doc = WebService::Solr::Document->new( @fields_array ) || die "cant newdoc $!";

#return $newdoc->value_for( 'id' ) ;	
	my $result = $SOLR->add( $doc ) ;
	
    # If the query isn't forcibly stringified an exception may be thrown.
#    my $query = sprintf( "%s", WebService::Solr::Query->new($params) );
    #my $result = $SOLR->delete_by_query( $query ) ;    
   
 #  $SOLR->commit() ;
   return $result ;
}


1;
