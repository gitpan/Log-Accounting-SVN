use inc::Module::Install;

name            ('Log-Accounting-SVN');
abstract        ('Accounting svn repository');
author          ('Kang-min Liu <gugod@gugod.org>');
license         ('perl');
version_from    ('lib/Log/Accounting/SVN.pm');
requires        ('Algorithm::Accounting');
build_requires  ('Test::More');

install_script  ('bin/svn-accounting.pl');

&WriteAll;

