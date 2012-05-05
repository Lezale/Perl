#! perl -w

use 5.014;
use autodie;
use strict;

my $success = open STDIN, "<", "D:\\StrawberryPerl\\Practice\\Input.txt";

if ($success)
{
   while (<>)
   {
      if (/fred/)
      {
         print "Found the target string: $_";
      }
   }
}