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

=pod
my $V = CalEvt->new ;

my $eastallen = '39.97,-75.13' ;

#{!geofilt pt=39.97,-75.13 sfield=latlong d=5}

my $request1 = {
    text => 'carnegie',
    location => $eastallen , 
    distance => 211,
#    fl => 'idn' 
    } ;
    

my $t1 = $V->model( 'Solr::Venue' )->Search( $request1 ) ;
ok( $t1, "Search returned a true value $t1" );
my @docs = @{$t1} ;
note( 'First Doc is: ', $docs[0] );
foreach my $doc( @docs ) {
    foreach my $val ( qw / idn name housenum street city state postcode latlong / ) {
    note( $doc->value_for( $val )) ;} }
note( scalar( @docs ) . ' Documents.' );


=pod
my $houseaddr1 = $V->model('MapQuest')->Locate( { location => $home1 } );
is( $houseaddr1, $eastallen, "GeoCode for $home1 is $eastallen" );

my $houseaddr2 = $V->model('MapQuest')->Locate( { location => $home2 } );
is( $houseaddr2, $eastallen, "GeoCode for $home2 is $eastallen" );

my $houseaddr3 = $V->model('MapQuest')->Locate( { location => $home3 } );
is( $houseaddr3, $eastallen, "GeoCode for $home3 is $eastallen" );

my %kimmel = (
    housenum => 300,
    street => 'S. Broad Street',
    city => 'Philadelphia',
    state => 'PA',
    postcode => '19102',
    country => 'USA', ) ;
my $kimmelcode = '39.95,-75.16';   
my $kimmelresult = $V->model('MapQuest')->Locate( \%kimmel );
is( $kimmelresult, $kimmelcode, "Kimmel Centre at $kimmelcode" ) ;   

my $carnegie = {
    housenum => 881,
    street => '7th Ave',
    city => 'New York',
    state => 'NY',
    country => 'USA', } ; 
my $carnegie_geo = '40.76,-73.98' ;
my $carnegieresult =  $V->model('MapQuest')->Locate( $carnegie );
is( $carnegieresult, $carnegie_geo, "Carnegie Hall at $carnegie_geo" ) ;   

=cut