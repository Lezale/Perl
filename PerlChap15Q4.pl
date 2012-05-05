#! perl -w

use 5.014;
use autodie;
use strict;

sub divisors
{
   my $number = shift;
   
   my @divisors = ();
   
   foreach my $divisor (2 .. ($number/2))
   {
      push @divisors, $divisor unless $number % $divisor;
   }
   
   return @divisors;
}

if (@ARGV == 1)
{
   my $number = shift @ARGV;
   given ($number)
   {  
      when (/[^\d+]/) { print ("Not a number.\n"); } #Implied break stops execution here.
      
      my @divisors = &divisors ($number);
      
      when (2 ~~ @divisors)  { print ("Number is even.\n"); continue; }
      when (!2 ~~ @divisors) { print ("Number is odd.\n"); continue; }
      when (13 ~~ @divisors) { print ("Number is divisible by 13.\n"); continue; }
      
      my @emptyList;
      when (@divisors ~~ @emptyList) { print ("Number is prime.\n"); }
      
      foreach (@divisors)
      {
         print ("One divisor is: $_\n");
      }
   }
}