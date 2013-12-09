use strict;
use warnings;

use Test::WWW::Mechanize::PSGI;
use Plack::Util;

use FindBin qw($Bin);

my $app = Plack::Util::load_psgi "${Bin}/myapp.psgi";

my $mech = Test::WWW::Mechanize::PSGI->new(
    app => $app,
);

my $start_mem = get_mem();
for my $i (0..10_000) {
    $mech->get('/');
    print "${i} requests\n" if ( $i % 1000 ) == 0;
}
my $end_mem = get_mem();

print "start mem usage: ${start_mem}mb\n";
print "end mem usage: ${end_mem}mb\n";
print "diff " . ($end_mem - $start_mem) . "mb\n";

sub get_mem {
    my $mem = `grep VmRSS /proc/$$/status`;
    return [split(qr/\s+/, $mem)]->[1] / 1024;
}
