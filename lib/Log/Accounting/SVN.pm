package Log::Accounting::SVN;
use strict;
use warnings;
use Spiffy '-Base';
use Algorithm::Accounting;
use SVN::Log;
our $VERSION = '0.01';

field 'repository';
field 'quiet';

field '_algo';

sub process {
  $self->repository || die "Must set repository\n";
  my $acc = Algorithm::Accounting->new(fields => [qw/author/]);

  $self->_algo($acc);

  my $append = sub {
    my ($paths,$revision,$author,$date,$message) = @_;
    unless($self->quiet) { print STDERR "$revision\r" if($revision); }
    $acc->append_data([[ $author ]]) if($author);
  };

  SVN::Log::retrieve ({
		       repository => $self->repository,
		       start => 1,
		       end   => -1,
		       callback => $append
		      });
  return $self;
}

sub report {
  my $algo = $self->_algo || die("Can't report without algo obj");
  $algo->report;
}

sub result {
  my $algo = $self->_algo || die("Can't return result without algo obj");
  $algo->result(@_);
}

1;

__END__

=head1 NAME

  Log::Accounting::SVN - Accounting svn repository

=head1 SYNOPSIS

  my $acc = Log::Accounting::SVN->new(repository => 'svn://');
  $acc->process->report;

=head1 DESCRIPTION

This module make use of L<Algorithm::Accounting> and L<SVN::Log> to do
simple accounting of any subversion repository (not necessarily local,
as long as you can do "svn log" to). The installed C<svn-accounting.pl>
script demostrate a simple use to this module, you may try:

  svn-accounting.pl http://svn.collab.net/repos/svn/

This will show the basic accounting information of subversion developers.

So far it's quite simple and no big deal, different fields will
be accounted in the future.

=head1 COPYRIGHT

Copyright 2004 by Kang-min Liu <gugod@gugod.org>.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

See <http://www.perl.com/perl/misc/Artistic.html>

=cut

