package shinshu2016::Web::C::List;
use strict;
use warnings;
use utf8;

sub index {
    my ($class, $c) = @_;
    my $login = $c->session->get('login');

    my @list = $c->db->search('entry',{ cancel => undef },{ order_by => { updated_on => 'desc'} } );
    return $c->render('list.tx', {
        login => $login,
        list => \@list,
    });
}

1;
