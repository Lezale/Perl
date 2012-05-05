#! perl -w

use 5.014;
use autodie;
use strict;

while (<>)
{  
   chomp;
   if (/\A(\w+)\w?(\w+)\z/s)
   {
      print ("Match found: |$`<$&>$'|\n");
   }
   else
   {
      print ("No match: |$_|\n");
   }
}