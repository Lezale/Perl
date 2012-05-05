#! perl -w

use strict;
use 5.014;

sub greet
{
   state $lastGreeted;

   my $outputString = "Hi " . $_[0] . "!";
   
   if (!$lastGreeted)
   {
      $outputString .= "  You are the first one here!\n";
   }
   else
   {
      $outputString .= "  $lastGreeted is also here!\n";
   }
   
   $lastGreeted = pop @_;
   
   print $outputString;
}

&greet ("Fred");
&greet ("Barney");