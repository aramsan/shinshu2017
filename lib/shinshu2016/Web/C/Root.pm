package shinshu2016::Web::C::Root;
use strict;
use warnings;
use utf8;

sub index {
    my ($class, $c) = @_;

    my $login = $c->session->get('login') ? 1 : undef;

    return $c->render('index.tx', {
        login => $login,
        title => "SOARER FESTIVAL 2015 | Top Page",
    });
}

1;
