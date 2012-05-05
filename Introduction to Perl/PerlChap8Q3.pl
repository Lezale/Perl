#! perl -w

use 5.014;
use autodie;
use strict;

my $open_success = open STDIN, "<", "D:\\StrawberryPerl\\Practice\\Input.txt";

if ($open_success)
{
   while (<>)
   {
      chomp;
      
      if (m/(\w*a\b)/)
      {
         print '$1', " contains '$1'\n";
         #print ("Match: |$`<$&>$'|\n");
      }
      else
      {
         print ("No match: |$_|\n");
      }
   }
}