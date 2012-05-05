#! perl -w

use 5.014;
use autodie;
use strict;

print ("Enter words to format:\n");

chomp (my @strings = <STDIN>);
print ((0..9)x4, "\n");

foreach (@strings)
{
   printf ("%20s\n", $_);
}

