#! perl -w

use 5.014;
use autodie;
use strict;

if (@ARGV)
{
   my $oldestFile = shift @ARGV;
   my $oldestFileAge = -M $oldestFile;

   foreach (@ARGV)
   {
      my $age = -M $_;

      ($oldestFileAge, $oldestFile) = ($age, $_)
         if ($age > $oldestFileAge);
   }

   print ("The oldest file detected is $oldestFileAge days old: $oldestFile\n");
}