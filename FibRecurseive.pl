#! perl -w

use 5.014;
use autodie;
use strict;

sub Fib
{
   my $previous = shift;
   my $current = shift;
   my $max = shift;
   
   unless ($current > $max)
   {
      print ($current);
      &Fib ($current, $previous + $current, $max);
   }
}

sub FibFromZero
{
   my $max = shift;
   
   &Fib (0, 1, $max);
}

&FibFromZero (10);