#! perl -w

use 5.014;
use autodie;
use strict;

sub parseDateString
{
   my $dateString = shift @_;
   my $ret_val;
   
   $ret_val = ($dateString ~~ /\A(Mon|Tues|Wed|Thurs|Fri)/) ? "Get to work!" : "Go play.";
}

if (open (my $dateHandle, "-|", "localtime.pl"))
{
   while (<$dateHandle>)
   {
      print (&parseDateString ($_));
   }
}