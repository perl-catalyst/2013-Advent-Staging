package MyApp;

use Pod::Markdown;

(caller() ? 1 : do {
  (my $parser = Pod::Markdown->new)
    ->parse_from_file(__FILE__);
  print $parser->as_markdown });

=head1 NAME

MyApp - A demo application

=head1 DESCRIPTION

Demonstration of using the L<PSGI> protocol to refactor application functionality
in two ways.  One, to show how to use middleware to bypass L<Catalyst> for
speed purposes and two, show how to wrap a PSGI service in a L<Catalyst::Model>.

In both cases we could use the PSGI protocol to create standalone web services
that can interoperation with Catalyst if desired, but yet do not require stand
alone serving (can run in the same process as the main application.)  Yet later,
we can very easily break out those services and run them independently, should
that be desired.

Sample application is only a sketch, it does not account for or take advantage
of any asynchronous, evented logic.

This application exposes four http endpoints, two handled by L<Catalyst> and
two by L<Web::Simple>.

    /catalyst-hello
    /websimple-hello
    /catalyst-now
    /now

The first two are simple template drive hello world style pages.  It demos how
to use middleware to intercept the request from L<Catalyst>, but also lets you
inform the intercepting application from L<Catalyst>

The third is a web page which displays the current time, as retrieved from a
JSON web service driven by L<Web::Simple>, and the forth is the underlying
JSON service.

Even though two applications are running, we only need one server, since all
communication is done via the PSGI protocol.  It would be easy to convert this
application to run with the web service on a separate server.

=head1 SEE ALSO

The following modules or resources may be of interest.

L<Catalyst::Runtime>, L<Plack>

=head1 AUTHOR

    John Napiorkowski C<< <jjnapiork@cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2013, John Napiorkowski L<email:jjnapiork@cpan.org>

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut


