#! perl -w

use 5.014;
use autodie;
use strict;

sub printStatistics
{
   foreach (@_)
   {
      if (-e $_)
      {
         say "$_ exists.";

         if (-r $_)
         {
            say "$_ is readable.";
         }
         
         if (-w $_)
         {
            say "$_ is writable.";
         }
         
         if (-x $_)
         {
            say "$_ is executable.";
         }
      }
   }
}

printStatistics (@ARGV);