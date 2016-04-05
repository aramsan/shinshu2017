package shinshu2016::Web::C::Share;
use strict;
use warnings;
use utf8;

sub index {
    my ($class, $c) = @_;

    return $c->render('index.tx', {
        title => "SOARER FESTIVAL 2015 | Top Page",
    });
}

1;
