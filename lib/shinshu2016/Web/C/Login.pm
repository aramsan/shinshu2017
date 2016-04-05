package shinshu2016::Web::C::Login;
use strict;
use warnings;
use utf8;

sub login {
    my ($class, $c) = @_;

    return $c->render('index.tx', {
        title => "SOARER FESTIVAL 2015 | Top Page",
    });
}

sub logout {
    my ($class, $c) = @_;

    return $c->render('index.tx', {
        title => "SOARER FESTIVAL 2015 | Top Page",
    });
}

1;
