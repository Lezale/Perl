#! perl -w

use 5.014;
use strict;
use autodie;

(my $file, my $lines) = @ARGV;

print ("Args: $file, $lines\n");

if (open (my $FH, "<", $file))
{
   my %indices;
   my $lineNum = 0;

   while (<$FH>)
   {
      $indices {$lineNum++} = length ($_) + 1;
   }
 
   my $seekBack = 0;
   foreach ((sort {$a <=> $b} keys %indices) [$lineNum - $lines .. $lineNum - 1])
   {
      $seekBack += $indices{$_};
   }
   
   seek ($FH, -$seekBack, 2);
   
   while (<$FH>)
   {
      print $_;
   }
   
   seek ($FH, 0, 0);
   
   my @linesThatMatch = grep /use/i, <$FH>;
   
   foreach (@linesThatMatch)
   {
      print ("Matched line: $_\n");
   }
}