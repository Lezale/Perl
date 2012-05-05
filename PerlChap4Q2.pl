#! perl -w

use strict;

sub sum
{
   my $total;
   foreach my $value (@_)
   {
      $total += $value;
   }
   
   return $total;
}

print &sum (1..1000). "\n";