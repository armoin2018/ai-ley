#!/usr/bin/env perl
use strict;
use warnings;
use v5.20;
use autodie;
use Getopt::Long;
use Pod::Usage;

my %opts = (
    input  => '',
    output => '',
    help   => 0,
);

GetOptions(\%opts, 'input=s', 'output=s', 'help|h') or pod2usage(2);
pod2usage(1) if $opts{help};

__END__
=head1 NAME
script_name - Description

=head1 SYNOPSIS
script_name [options]