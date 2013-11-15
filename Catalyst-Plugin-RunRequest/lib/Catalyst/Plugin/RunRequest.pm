package Catalyst::Plugin::RunRequest;
 
use Moose::Role;

our $VERSION = '0.001';

my $_test_request_spec_to_http_request = sub {
  my ($method, $path, @rest) = @_;
 
  # if it's a reference, assume a request object
  return $method if ref($method);
 
  if ($path =~ s/^(.*?)\@//) {
    my $basic = $1;
    require MIME::Base64;
    unshift @rest, 'Authorization:', 'Basic '.MIME::Base64::encode($basic);
  }
 
  my $request = HTTP::Request->new($method => $path);
 
  my @params;
 
  while (my ($header, $value) = splice(@rest, 0, 2)) {
    unless ($header =~ s/:$//) {
      push @params, $header, $value;
    }
    $header =~ s/_/-/g;
    if ($header eq 'Content') {
      $request->content($value);
    } else {
      $request->headers->push_header($header, $value);
    }
  }
 
  if (($method eq 'POST' or $method eq 'PUT') and @params) {
    my $content = do {
      require URI;
      my $url = URI->new('http:');
      $url->query_form(@params);
      $url->query;
    };
    $request->header('Content-Type' => 'application/x-www-form-urlencoded');
    $request->header('Content-Length' => length($content));
    $request->content($content);
  }
 
  return $request;
};

sub run_request {
  my ($self, @req) = @_;
 
  require HTTP::Request;
  require HTTP::Message::PSGI;
 
  my $http_request = $_test_request_spec_to_http_request->(@req);
  my $psgi_env = HTTP::Message::PSGI::req_to_psgi($http_request);
  my $psgi_response = $self->psgi_app->($psgi_env);

  return HTTP::Message::PSGI::res_from_psgi($psgi_response);
}

sub GET  { shift->run_request('GET',  @_) }
sub POST { shift->run_request('POST', @_) }

=head1 TITLE

Catalyst::Plugin::RunRequest - Run a request on your Catalyst Application

=head1 SYNOPSIS

    use MyApp;

    my $http_response = MyApp->run_request(GET => '/');

=head1 DESCRIPTION

A simple plugin that allows you to call your application against a single
request.  Useful for testing.

This is good unless you are invoking your L<Catalyst> application via a
customized C<psgi> file.

=head1 METHODS

This plugin defines the following methods

=head2 run_request

  my $res = MyApp->run_request(GET => '/' => %headers);
 
  my $res = MyApp->run_request(POST => '/' => %headers_or_form);
 
  my $res = MyApp->run_request($http_request);
 
Accepts either an L<HTTP::Request> object or ($method, $path) and runs that
request against the application, returning an L<HTTP::Response> object.
 
If the HTTP method is POST or PUT, then a series of pairs can be passed after
this to create a form style message body. If you need to test an upload, then
create an L<HTTP::Request> object by hand or use the C<POST> subroutine
provided by L<HTTP::Request::Common>.
 
If you prefix the URL with 'user:pass@' this will be converted into
an Authorization header for HTTP basic auth:
 
  my $res = $app->run_request(
              GET => 'bob:secret@/protected/resource'
            );
 
If pairs are passed where the key ends in :, it is instead treated as a
headers, so:
 
  my $res = $app->run_request(
              POST => '/',
             'Accept:' => 'text/html',
              some_form_key => 'value'
            );
 
will do what you expect. You can also pass a special key of Content: to
set the request body:
 
  my $res = $app->run_request(
              POST => '/',
              'Content-Type:' => 'text/json',
              'Content:' => '{ "json": "here" }',
            );

=head1 SEE ALSO

L<Catalyst>

=head1 AUTHOR

John Napiorkowski L<email:jjnapiork@cpan.org>

=head1 SPECIAL THANKS

Thank to mst for the code example in L<Web::Simple>, which I basically cribbed
(as well as the docs..).

=head1 COPYRIGHT & LICENSE

Copyright 2013, John Napiorkowski L<email:jjnapiork@cpan.org>

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
