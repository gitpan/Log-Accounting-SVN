#!/usr/bin/perl
use strict;
use warnings;
use Log::Accounting::SVN;

my $repo = shift || die "Have to give a repository path\n";

Log::Accounting::SVN->new(repository => $repo)->process->report;
