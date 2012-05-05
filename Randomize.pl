#! perl -w

use 5.014;
use autodie;
use strict;

my $file = shift;

if (open (my $FH, "<", $file))
{
   my @lines = <$FH>;
   my %output;
   
   foreach (@lines)
   {
      my $rand;
      do
      {
         $rand = rand ();
      } while ($rand ~~ %output);
      
      $output {$rand} = $_;
   }
   
   foreach (keys %output)
   {
      print ("$output{$_}");
   }
}