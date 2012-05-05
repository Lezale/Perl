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
      
      if (m/(?<CaptureName>\w*a\b)(.{0,5})/)
      {
         print '$+{CaptureName} contains ', "$+{CaptureName}\n";
         print '$2 contains ', "$2\n";
         #print ("Match: |$`<$&>$'|\n");
      }
      else
      {
         print ("No match: |$_|\n");
      }
   }
}