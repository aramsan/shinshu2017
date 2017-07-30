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
any '/logini/check'  => 'Login#check';
any '/logout' => 'Login#logout';

# 参加登録系
any '/register' => 'Register#index';
any '/register/submit' => 'Register#submit';

# 参加者リスト
get '/list' => 'List#index';
get '/list/' => 'List#index';

# シェア
get '/share' => 'Static#share';
get '/gallery' => 'Static#gallery';
get '/announse170514' => 'Static#month3';
get '/announse_spa' => 'Static#month2';
get '/announse_food' => 'Static#month1';
get '/announse_souvenir' => 'Static#week2';

# 管理画面
any '/admin' => 'Admin#index';
any '/admin/' => 'Admin#index';

1;
