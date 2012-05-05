#! perl -w

use 5.014;
use autodie;
use strict;

if (@ARGV == 2) #Two arguments needed
{
   my $source = shift @ARGV;
   my $target = shift @ARGV;
   
   if (-e $target)
   {
      if (-d $target) # Is a directory?
      {
         $target = "$target\\$source";
      }
   }

   link $source => $target;
}