package shinshu2016::Web::C::Register;
use strict;
use warnings;
use utf8;
use File::Copy;
use File::Spec;
use File::Basename;
use Image::Imlib2;
use Time::Piece;

my $upload_dir = 'static/upload';
my $thumbnail_dir = 'static/thumbnail';

sub index {
    my ($class, $c) = @_;

    $c->session->remove('register');
    my $input = &_input($c);
use Data::Dumper;
print Dumper($input) . "\n";   
    my $id = $c->session->get('login');
    #  ログインしていたら更新
    if ($id) {
        $input = $c->db->single('entry', { id => $id });
        $c->session->set('register'=>1);
        $input->{'email'} = $c->crypt->decrypt_hex($input->email);
        return $c->render('register/form.tx', { items => $input } );
    }
    # 登録済みのメアドで登録しようとするとログイン画面へ
    my $entry = $c->db->single('entry', { email => $c->crypt->encrypt_hex($input->{'email'}) });
    if ($entry) {
        return $c->render('login.tx', {
            error => "そのメアドは登録済みです。ログインして登録情報を変更してください",
            email => $input->{'email'},
        });
    }
    $c->session->set('register'=>1);
    return $c->render('register/form.tx', { items => $input } );
}

sub submit {
    my ($class, $c) = @_;
    return $c->redirect('/') unless $c->session->get('register');
    $c->session->remove('register');

    my $input = _input($c);
print Dumper($input)."\n";
    my $id = $c->session->get('login');
    if ($id) {
        $input->{id} = $id;
        _update($c,$input);
    } else {
        my $insert = _insert($c,$input);
print Dumper($insert->id)."\n";
        $c->session->set('login'=> $insert->id);
    }
    $input->{email} = $c->crypt->decrypt_hex($input->{email});
print Dumper($input)."\n";
    return $c->render('register/submit.tx', {
        items => $input,
    });
}

sub _input {
    my $c = shift;
    # 画像アップロード
    my $upload = $c->req->upload('picture');
    my $picture;
    if($upload){
        my $ext = _valid_type($upload->content_type);
        if($ext){
          my $src = $upload->tempname;
          $picture = _create_filename($ext);
          my $dst = File::Spec->catfile($c->base_dir(),$upload_dir,$picture);
          copy $src,$dst;

          # サムネイル画像の作成
          my $image = Image::Imlib2->load("$dst");
          my $width  = $image->get_width;
          my $height = $image->get_height;
          if ($width > $height) {
              $image = $image->create_scaled_image(120, int($height * 120 / $width));
          }
          else {
              $image = $image->create_scaled_image(int($width * 120 / $height), 120);
          }

          $image->set_quality(100);
          $image->save("$thumbnail_dir/$picture");
        }
    }    
    return {
        'email' => $c->req->param('email'),
        'name'  => $c->req->param('name'),
        'password' => $c->req->param('password') || undef,
        'type' => $c->req->param('type') || undef,
        'grade' => $c->req->param('grade') || undef,
        'departure' => $c->req->param('departure') || undef,
        'adult' => $c->req->param('adult') || 1,
        'child' => $c->req->param('child') || 0,
       'picture' => $picture,
        'message' => $c->req->param('message') || undef,
        'updated_on' => \'now()',
    };
}

sub _valid_type {
    my $type = shift;

    my %valid_types = ('image/jpeg' => 'jpg');

    return $valid_types{$type};
}

sub _create_filename {
    my $ext = shift;

    my $date = localtime;
    my $rand_num = sprintf "%05s",int(rand 100000);

    return 'image-'.$date->datetime(date => '',time => '',T => '').'-'.$rand_num.'.'.$ext;
}

sub _insert {
    my ($c, $input) = @_;
    $input->{email}    = $c->crypt->encrypt_hex($input->{email});
    $input->{password} = $c->crypt->encrypt_hex($input->{password});
    return $c->db->insert( entry=>$input ); 
}

sub _update {
    my ($c, $input) = @_;
    $input->{email}    = $c->crypt->encrypt_hex($input->{email});
    $input->{password} = $c->crypt->encrypt_hex($input->{password});
    return $c->db->update( entry=>$input, { id => $input->{id}} ); 
}

1;
