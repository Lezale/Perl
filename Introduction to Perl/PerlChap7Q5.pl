#! perl -w

use 5.014;
use autodie;
use strict;

my $success = open STDIN, "<", "D:\\StrawberryPerl\\Practice\\Input.txt";

if ($success)
{
   while (<>)
   {
      if (/(.)\g{1}/)
      {
         print "Found the target string: $_";
      }
   }
}