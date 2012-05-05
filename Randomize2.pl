#! perl -w

use 5.014;
use strict;
use autodie;

my @lines = <>;

my %randomize;

foreach (@lines)
{
   my $randomNumber;
   
   do
   {
      $randomNumber = rand ();
   } while ($randomize {$randomNumber});
   
   $randomize {$randomNumber} = $_;
}

my $lineNumber = 0;
foreach (keys (%randomize))
{
   ++$lineNumber;
   print ("$lineNumber: $randomize{$_}");
}