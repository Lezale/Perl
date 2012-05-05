#! perl -w

use 5.014;
use autodie;
use strict;

print ("Enter words to format:\n");

chomp (my @strings = <STDIN>);

my $columnSize = shift (@strings);

print ((0..9)x($columnSize / 10 + 4), "\n");

foreach (@strings)
{
   printf ("%${columnSize}s\n", $_);
}

