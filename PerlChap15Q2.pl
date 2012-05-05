#! perl -w

use 5.014;
use autodie;
use strict;

while ()
{
   print ("Enter number to analyze: ");

   chomp (my $target = <>);

   given ($target)
   {
      when (/[^\d+]/) { print ("Not a number!\n"); }
      when ($target % 3 == 0) { print ("Fizz\n"); continue }
      when ($target % 5 == 0) { print ("Bin\n"); continue }
      when ($target % 7 == 0) { print ("Sausage\n"); }
   }
}   