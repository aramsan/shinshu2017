package shinshu2016::Web::C::Register;
use strict;
use warnings;
use utf8;

sub index {
    my ($class, $c) = @_;

    return $c->render('index.tx', {
        title => "SOARER FESTIVAL 2015 | Top Page",
    });
}

sub mail {
    my ($class, $c) = @_;
    my $entry; 
    my $input = {
        'email' => $c->req->param('email'),
        'name'  => $c->req->param('name'),
    };

    $entry = $c->db->single('entry', { email => $input->{'email'} });
    if ($entry) {
        return $c->render('login.tx', {
            entry => $entry,
        });
    }
    return $c->render('register/index.tx', { items => $input } );
}

sub mail_submit {
    my ($class, $c) = @_;

    return $c->render('index.tx', {
        title => "SOARER FESTIVAL 2015 | Top Page",
    });
}

sub update {
    my ($class, $c) = @_;

    return $c->render('index.tx', {
        title => "SOARER FESTIVAL 2015 | Top Page",
    });
}

sub ok {
    my ($class, $c) = @_;

    return $c->render('index.tx', {
        title => "SOARER FESTIVAL 2015 | Top Page",
    });
}

1;
