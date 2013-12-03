package SolrDemo::Controller::Root;
use Moose;
use namespace::autoclean;
use WebService::Solr::Query;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

SolrDemo::Controller::Root - Root Controller for SolrDemo

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub response2info {
    my $data = shift ;
    }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
#    $c->model('MSolr::Method')->List();
    my $response = $c->model('MSolr')->search( WebService::Solr::Query->select_all() ) ;
$c->log->info( $response );    
    # Hello World
    $c->response->body( $c->welcome_message );
}

sub thincount :Local :Args(0) {
    my ( $self, $c ) = @_;
    my $response = $c->model('MSolr')->search( '(*:*)' ) ;
    
    my $status = $response->solr_status();
    my $raw = $response->raw_response() ;
    my (@keys ) = keys( %{$raw} ) ;
$c->log->info( $response );    
$c->log->info( $status );    
$c->log->info( @keys );    
my $pre = ''; 
    $pre .= "\n_msg\n" . $raw->{'_msg'} ;
    $pre .= "\n_headers"  ;
     my %hheaders = %{$raw->{'_headers'}} ;
     for ( keys %hheaders ) { $pre .= "\n    $_ = $hheaders{$_}" ; }
     $pre .= "\n_request" ;
     my %rreq = %{$raw->{'_request'}} ;
     for ( keys %rreq ) { $pre .= "\n    $_ = $rreq{$_}" ; }
    $pre .= "\n_content</pre>\n" . $raw->{'_content'} . '<pre>';
    $pre .= "\n_rc\n" . $raw->{'_rc'} ;
    $pre .= "\n_protocol\n" . $raw->{'_protocol'} ; 
    my @docs = $response->docs ;
    my $dcount = scalar( @docs );
$c->log->info( "Docs Count $dcount" );       
    # Hello World
    $c->response->body( "<pre>$pre </pre>" );
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

brainbuz,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
