package shinshu2016::Web::C::List;
use strict;
use warnings;
use utf8;

sub index {
    my ($class, $c) = @_;
    my $login = $c->session->get('login');

    my @list = $c->db->search('entry');
    return $c->render('list.tx', {
        list => \@list,
    });
}

1;
