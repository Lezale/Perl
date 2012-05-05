#! perl -w

use 5.014;
use autodie;
use strict;

while (<>)
{
   chomp;
   
   if (m/match/)
   {
      print ("Match found: |$`<$&>$'|\n");
   }
   else
   {
      print ("No match: |$_|\n");
   }
}