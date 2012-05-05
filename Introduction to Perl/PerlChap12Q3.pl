#! perl -w

use 5.014;
use autodie;
use strict;

my $oldestFile;
my $oldestFileAge = 0;

foreach (@ARGV)
{
   print ("File is readable, writable, and owned by you:  $_\n") if -r -w -o ($_);
}