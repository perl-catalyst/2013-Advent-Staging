use strict;
use warnings;
use Test::More;         
                
BEGIN { use_ok 'SolrDemo' }

my $C = SolrDemo->new ;
my @docs = $C->model('Solr')->List( { cat => 'electronics', manu => 'corsair' } );
is( scalar(@docs), 2, 'We expect 2 docs' );

my $carnegiehall = '40.76,-73.98' ;
my $geofilt = &SolrDemo::Model::Solr::_GeoFilter( $carnegiehall, 'store', 400 ) ;
is( $geofilt, '{!geofilt pt=40.76,-73.98 sfield=store d=400}', 'Test geofilter construction using carnegie hall as a testcase');
my @docs2 = $C->model('Solr')->Kimmel( 1600 ) ;
is( scalar(@docs2), 3, 'There are 3 items within 1600 km of the Kimmel Center' );

done_testing();