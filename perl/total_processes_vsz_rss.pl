#!/bin/perl
use warnings;
use strict;

# Minimalistic, simple script that shows the total RSS (Resident Set Size) of all processes, 
# as well as the total VSZ (Virtual Size) of all processes.

# This is the only dependency of this script.
# Install it with: "cpan Number::Bytes::Human". Easy enough.
use Number::Bytes::Human qw(format_bytes);

# This script is Linux only. `ps` on Darwins suck!
if ("$^O" ne "linux") {
    print "Linux Only Man!\n";
    exit;
}

# Execute the ps.
my $PSout = `ps o vsz=,rss= ax`;

my @PSout_lines = split("\n", $PSout);

# This is the Resident Set Size (i.e. The number of pages in memory).
# PAGESIZE is used with conjunction with this to calculate the overall memory usage.
my $RSS_total = 0;
my $PAGESIZE = `getconf PAGESIZE`;

# This is tha Virtual Memory Size.
my $VSZ_total = 0;

foreach my $PSout_line(@PSout_lines) {
    my ($vsz, $rss) = split(" ", $PSout_line);

    $RSS_total += $rss;
    $VSZ_total += $vsz;
}
$RSS_total *= $PAGESIZE;


print "#####################################################\n";
print " Total Virtual Size Of Processes: \t\t". format_bytes($VSZ_total) . "\n";
print " Total Resident Set Size Of Processes: \t\t". format_bytes($RSS_total) . "\n";
print "#####################################################\n";