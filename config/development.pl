use File::Spec;
use File::Basename qw(dirname);
my $basedir = File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__), '..'));
+{
    'DBI' => [
        "dbi:mysql:database=shinshu2016_dev",
        'root',
        '',
        {mysql_enable_utf8=>1}
    ],
    'crypt' => { 
        'key' => "446L8EeMge7T",   
    },
};


