#! perl -w

use 5.014;
use autodie;
use strict;

my $what = "fred|barney";

while (<>)
{
   chomp;

   if (/($what){3}/)
   {
      say "Pattern matched: $_";
   }
   else
   {
      say "Match failed";
   }
}