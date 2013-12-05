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

my $added1 = $C->model('Solr')->Add(
	{ name => 'Zune Player' , manu => 'Microsoft', features => 'Truly Obsolete', price => '300',
	store => '40.76,-73.98', cat => 'electronics', id => 'MSZUNE' } ) ;
is( $added1, 1, 'successfully added a zune located at Carnegie Hall to inventory' ); 	

my @fields = (
    [ id     => 1,               { boost => 1.6 } ],
    [ sku    => 'A6B9A',         { boost => '1.0' } ],
    [ manu   => 'The Bird Book', { boost => '7.1' } ],
    [ weight => '4.0',           { boost => 3.2 } ],
    [ name   => 'Sally Jesse Raphael' ],
);

my @docs3 = $C->model('Solr')->Kimmel( 1600 ) ;

is( scalar(@docs3), 4, 'There are now 4 items within 1600 km of the Kimmel Center' );

note( 'list out the 4 items with 1600km of the Kimmel Center' );
foreach my $d3 ( @docs3 ) {
	note( $d3->value_for('name') . ' ID:'. $d3->value_for('id') . ' Manu:' . $d3->value_for('manu') ); }

my $updated1 = $C->model('Solr')->Add(
	{ id => 'MSZUNE' ,
		features => 'Half price Closeout Sale on our last MS ZUNE! Save $150',
		price => '150' , 
		store => '40.76,-73.98', } ) ;
is( $updated1, 1, 'Updated the Zune for Closeout!' );
		
my @zunedocs = $C->model('Solr')->List( { id => 'MSZUNE' } );
my $zunedoc = $zunedocs[0];
is( $zunedoc->value_for('price'), 150, 'Prove that zune now costs $150' );

note( 'repeat the items list to show updated zune');
@docs3 = $C->model('Solr')->Kimmel( 1600 ) ;
no warnings 'uninitialized';
foreach my $d3 ( @docs3 ) {
	note( $d3->value_for('name') . ' ID:'. $d3->value_for('id') . ' Manu:' . $d3->value_for('manu') ); }

my $delete1 = $C->model('Solr')->Delete({ id => 'MSZUNE' }) ;
is( $delete1, 1, 'deleted the the zune player') ;

done_testing();
