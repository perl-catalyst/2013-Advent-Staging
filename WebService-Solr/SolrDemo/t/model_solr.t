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

#my $delete1 = $C->model('Solr')->Delete({ id => 'GB18030TEST' }) ;
#is( $delete1, 1, 'deleted the record in chineese') ;

my $add = $C->model('Solr')->Add(
	{ name => 'Zune Player' , manu => 'Microsoft', features => 'Truly Obsolete', price => '300,USD',
	store => '40.76,-73.98', cat => 'electronics', id => 'MSZUNE' } ) ;
is( $add, 1, 'successfully added a zune located at Carnegie Hall to inventory' ); 	

done_testing();
