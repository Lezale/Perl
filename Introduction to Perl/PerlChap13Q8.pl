#! perl -w

use 5.014;
use autodie;
use strict;

foreach (<"* .*">)
{
   if (-l $_)
   {
      my $linkTarget = readlink $_;
      print ("$_ -> $linkTarget");
   }
}