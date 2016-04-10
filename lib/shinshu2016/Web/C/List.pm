package shinshu2016::Web::C::List;
use strict;
use warnings;
use utf8;

sub index {
    my ($class, $c) = @_;
    my $login = $c->session->get('login');
    return $c->render('index.tx', {
        login => $login,
    });
}

1;
