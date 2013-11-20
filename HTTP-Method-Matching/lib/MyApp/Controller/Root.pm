package MyApp::Controller::Root;

use base 'Catalyst::Controller';

sub is_get    : GET Path('/test') { pop->res->body('GET') }

sub is_post   : POST Path('/test') { pop->res->body('POST') }

sub is_put    : PUT Path('/test') { pop->res->body('PUT') }

sub is_delete : DELETE Path('/test') { pop->res->body('DELETE') }

1;
