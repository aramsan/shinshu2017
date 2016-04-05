package shinshu2016::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use Module::Find qw(useall);

# Load all controller classes at loading time.
useall('shinshu2016::Web::C');

base 'shinshu2016::Web::C';

# トップ
get '/' => 'Root#index';

# ログイン
any '/login'  => 'Login#login';
any '/logout' => 'Login#logout';

# 参加登録系
any '/register' => 'Register#index';
any '/register/mail' => 'Register#mail';
post '/register/mailok' => 'Register#mail_submit';
any '/register/update' => 'Register#update';
post '/register/ok' => 'Register#ok';

# 参加者リスト
get '/list' => 'List#index';
get '/list/' => 'List#index';

# シェア
get '/share' => 'Share#index';

# 管理画面
any '/admin' => 'Admin#index';
any '/admin/' => 'Admin#index';

1;
