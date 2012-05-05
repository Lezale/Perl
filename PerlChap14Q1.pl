#! perl -w

use 5.014;
use autodie;
use strict;

print ("Input a list of numbers to sort (press CTRL-Z to end): ");
my @input = <>;

@input = sort { $a <=> $b } @input;

my $width = 0;

foreach (@input)
{
   $width = length $_ if length $_ > $width;
}

foreach (@input)
{
   printf ("%${width}s", $_);
}