#! perl -w

use strict;

sub sum
{
   my $total;
   foreach my $value (@_)
   {
      $total += $value;
   }
   
   $total;
}

sub average
{
   my $sum = &sum (@_);
   $sum / @_;
}

sub aboveAverage
{
   my @ret_val;
   my $average = &average (@_);
   
   foreach (@_)
   {
      if ($_ > $average)
      {
         push (@ret_val, $_);
      }
   }
   
   @ret_val;
}

my @fred = &aboveAverage (1..10);

print "\@fred is @fred\n";
print "(Should be 6 7 8 9 10)\n";

my @barney = &aboveAverage (100, 1..10);

print "\@barney is @barney\n";
print "(Should be just 100)\n";