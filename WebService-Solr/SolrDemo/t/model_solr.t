use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'SolrDemo' }

my $C = SolrDemo->new;
my @docs =
  $C->model('Solr')->List( { cat => 'electronics', manu => 'corsair' } );
is( scalar(@docs), 2, 'We expect 2 docs' );

my $carnegiehall = '40.76,-73.98';
my $geofilt = &SolrDemo::Model::Solr::_GeoFilter( $carnegiehall, 'store', 400 );
is(
    $geofilt,
    '{!geofilt pt=40.76,-73.98 sfield=store d=400}',
    'Test geofilter construction using carnegie hall as a testcase'
);
my @docs2 = $C->model('Solr')->Kimmel(1600);
is( scalar(@docs2), 3,
    'There are 3 items within 1600 km of the Kimmel Center' );

note( "\n* CRUD Tests *\n" );
my $added1 = $C->model('Solr')->Add(
    {
        name     => 'Zune Player',
        manu     => 'Microsoft',
        features => 'Truly Obsolete',
        price    => '300',
        store    => '40.76,-73.98',
        cat      => 'electronics',
        id       => 'MSZUNE'
    }
);
is( $added1, 1,
    'successfully added a zune located at Carnegie Hall to inventory' );

my @docs3 = $C->model('Solr')->Kimmel(1600);

is( scalar(@docs3), 4,
    'There are now 4 items within 1600 km of the Kimmel Center' );

# a subroutine to list a doc.
sub listdoc {
    my $d      = shift;
    my $string = '';
    $string .=
        ' ID: '
      . $d->value_for('id') . ' -- '
      . $d->value_for('name')
      . ' Manu: '
      . $d->value_for('manu') . "\n\t"
      . $d->value_for('features');
    return $string;
}

note( '* Display the 4 items within 1600km showing added record *');
for (@docs3) { note( &listdoc($_) ) }

my $updated1 = $C->model('Solr')->Add(
    {
        name     => 'Zune Player',
        manu     => 'Microsoft',
        features => 'Half price Closeout Sale on our last MS ZUNE! Save $150',
        price    => '150',
        store    => '40.76,-73.98',
        cat      => 'electronics',
        id       => 'MSZUNE'
    }
);

is( $updated1, 1, 'Updated the Zune for Closeout!' );

my @zunedocs = $C->model('Solr')->List( { id => 'MSZUNE' } );
my $zunedoc = $zunedocs[0];
is( $zunedoc->value_for('price'), 150, 'Prove that zune now costs $150' );

note( '* Display the Documents showing modified record for ZUNE. *');
@docs3 = $C->model('Solr')->Kimmel(1600);
for (@docs3) { note( &listdoc($_) ) }

my $delete1 = $C->model('Solr')->Delete( { id => 'MSZUNE' } );
is( $delete1, 1, 'delete returned success' );
@zunedocs = $C->model('Solr')->List( { id => 'MSZUNE' } );
is( scalar( @zunedocs ) , 0, 'Confirm it is deleted' );

# This test deletes data, after running it you must reset your data.
# Comment it or skip it to avoid.
my @before = $C->model('Solr')->List( { '*' => \'*' } );
my $delete2 = $C->model('Solr')->Delete( { cat => 'electronics' } );
my @after = $C->model('Solr')->List( { '*' => \'*' } );
is( scalar(@after) , 18, "There were 32 documents, there are now 18");

done_testing();
