package shinshu2016::Web::C::Login;
use strict;
use warnings;
use utf8;

sub login {
    my ($class, $c) = @_;

    my $login = 1;
    $c->session->set('login' => 1);

    return $c->render('login.tx', {
        login => $login,
        error => "error",
    });
}

sub logout {
    my ($class, $c) = @_;

    my $login = 0;
    $c->session->remove('login');

    return $c->render('index.tx', {
        login => undef,
        title => "SOARER FESTIVAL 2015 | Top Page",
    });
}

1;
