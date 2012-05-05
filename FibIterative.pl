#! perl -w

use 5.014;
use strict;
use autodie;

sub Fib
{
   my $max = shift;
   
   my $previous = 0;
   my $current = 1;
   
   while ($current < $max)
   {
      my $temp = $previous;
      print ($current);
      
      $previous = $current;
      $current = $temp + $current;
   }
}

&Fib (10);