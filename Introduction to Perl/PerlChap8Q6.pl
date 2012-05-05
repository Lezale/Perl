#! perl -w

use 5.014;
use autodie;
use strict;

while (<>)
{
   chomp;
   
   if ($_ =~ /.*\s\Z/)
   {
      print ("This input matched the criteria: ", $_, "^\n");
   }
   else
   {
      print ("This input did not match the criteria\n");
   }
}