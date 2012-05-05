#! perl -w

use strict;
use 5.014;

sub greet
{
   state @lastGreeted;

   my $outputString = "Hi " . $_[0] . "!";
   
   if (!@lastGreeted)
   {
      $outputString .= "  You are the first one here!\n";
   }
   else
   {
      $outputString .= "  I've seen:";
      
      foreach (@lastGreeted)
      {
         $outputString .= " $_";
      }
      
      $outputString .= "\n";
   }
   
   push (@lastGreeted,  pop @_);
   
   print $outputString;
}

&greet ("Fred");
&greet ("Barney");
&greet ("Wilma");
&greet ("Betty");