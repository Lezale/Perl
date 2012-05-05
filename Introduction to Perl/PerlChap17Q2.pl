#! perl -w

use 5.014;
use autodie;
use strict;

my @fileNames = glob "*";
my $outputFormat = "%5s\t%5s\t%5s\n";

foreach (@fileNames)
{
   if (open (my $statHandle, "-|", "dir $_")) # Using the file handle form of exec to capture program output.
   {
      my @statOutput = <$statHandle>; # Read the output from dir.
      
      # This is an exercise in formatting output of specific indices within a list.
      
      # Here we generate a new list by slicing the fifth, first, and zeroth indices from the @statOutput
      #   list.  Once this is complete the map operator performs a translation on this new list.
      #   It is the equivalent of:
      #   foreach (@list)
      #   {
      #      my $newValue = $_;
      #      my $newValue =~ s/\s*//g;
      #      push @newList $newIndex;
      #   }
      #
      # The result of this operation is fed into the printf, which is expecting three strings, as above.
      printf ($outputFormat, map { $_ =~ s/\s*//g; $_; } @statOutput [5, 1, 0]);
   }
}