package SolrDemo::Controller::Thin;
use Moose;
use namespace::autoclean;
use WebService::Solr::Query;

BEGIN { extends 'Catalyst::Controller' }

sub response2info {
    my $response = shift;
    my $raw      = $response->raw_response();
    my $pre      = '';
    $pre .= "\n_msg\n" . $raw->{'_msg'};
    $pre .= "\n_headers";
    my %hheaders = %{ $raw->{'_headers'} };
    for ( keys %hheaders ) { $pre .= "\n    $_ = $hheaders{$_}"; }
    $pre .= "\n_request";
    my %rreq = %{ $raw->{'_request'} };
    for ( keys %rreq ) { $pre .= "\n    $_ = $rreq{$_}"; }
    $pre .= "\n_content</pre>\n" . $raw->{'_content'} . '<pre>';
    $pre .= "\n_rc\n" . $raw->{'_rc'};
    $pre .= "\n_protocol\n" . $raw->{'_protocol'};
    $pre .= "\nRequest Status (via method)\n" . $response->solr_status();
    my @docs = $response->docs;
    $pre .= "\nDocument Count: " . scalar(@docs);
    return $pre;
 }

sub dump :Local :Args(0) {
    my ( $self, $c ) = @_;
    my $response   = $c->model('SolrModelSolr')->search(
        WebService::Solr::Query->new( { '*' => \'*' } ), 
        { rows => 10000 } );
    my @docs       = $response->docs;
    $c->log->info( "\nDocument Count: " . scalar(@docs) );
    my $pre = &response2info($response);
    $c->response->body("<pre>$pre </pre>");
}

sub select :Local :Args(0) {
    my ( $self, $c ) = @_;
my $response   = $c->model('SolrModelSolr')->search(
        WebService::Solr::Query->new( { text => ['hard drive'] } ), { rows => 10000 } );        
    my $pre = &response2info($response);
    $c->response->body("<pre>$pre </pre>");
}

    sub maxtor :Local :Args(0) {
        my ( $self, $c ) = @_;
        my $maxq = WebService::Solr::Query->new({ manu => ['maxtor'] });
        my $response   = $c->model('SolrModelSolr')->search(
            WebService::Solr::Query->new( 
                { text => ['hard drive'] } ), 
                { rows => 10000, fq => $maxq } );        
        my $pre = &response2info($response);
        $c->response->body("<pre>$pre </pre>");
    }     
    
sub realquery  :Local :Args(2) {
    my ( $self, $c, $fieldname, $fieldvalue ) = @_; 
    my $response = $c->model('SolrModelSolr')->search(
        WebService::Solr::Query->new( { $fieldname => [ $fieldvalue ] } ), { rows => 10000 } );  
    my @docs = $response->docs ;
    $c->stash(
        template => 'results.tt',
        field => $fieldname,
        value => $fieldvalue, 
        docs => \@docs );   
    }
    

__PACKAGE__->meta->make_immutable;

1;


=head1 AUTHOR

brainbuz,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
