#! perl -w

use 5.014;
use autodie;
use strict;

my @nums = 1..shift;

printf ("\t");
foreach (@nums)
{
   printf ("%-3d\t", $_);
}

printf ("\n");
foreach my $outer (@nums)
{
   printf ("%-3d\t", $outer);
   
   foreach my $inner (@nums)
   {
      printf ("%-3d\t", $inner * $outer);
   }
   printf ("\n");
}