#! perl -w

use 5.014;
use autodie;
use strict;

# This example uses no arrays.
if (@ARGV == 2)
{
   my $targetFile = $ARGV[0];
   my $leadingWindow = ($ARGV[1]) - 1;
   my $currentLine = 0;
   my $firstPass = 1;
   
   open (my $FH1, "<", $targetFile);
   open (my $FH2, "<", $targetFile);

   while ($_ = (<$FH1> or <$FH2>))
   {
      $currentLine++;
      
      if ($firstPass)
      {
         if (eof)
         {
            $firstPass = 0;
         }
         elsif ($currentLine > $leadingWindow)
         {
            <$FH2>;
         }
      }
      else
      {
         print ($_);
      }
   }
}
else
{
   die ("Invalid number of arguments.\n");
}

# Alternative method using seek.

if (@ARGV == 2)
{
   my $targetFile = shift (@ARGV);
   my $numLines = shift (@ARGV);
   my $currentLine = 0;
   
   my %fileInfo;
   
   open (my $FH, "<", $targetFile);
   
   while (<$FH>)
   {
      $fileInfo {$currentLine++} = (length $_) + 1; # Account for newline.
   }
   
   my $numBytes = 0;
   foreach ((sort { $a <=> $b } keys (%fileInfo)) [$currentLine - $numLines .. $currentLine - 1])
   {
      $numBytes += $fileInfo {$_};
   }
   
   seek ($FH, -$numBytes, 2);
   
   while (<$FH>)
   {
      print;
   }
}