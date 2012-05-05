#! perl -w

use 5.014;
use autodie;
use strict;

if (open (my $fileHandle, "<", ".\\PerlChap16Q4.pl"))
{
   my @lines;
   while (<$fileHandle>)
   {
      push (@lines, $_);
   }
   
   my $input;
   my @results;
   
   do
   {
      print ("Enter a pattern to find within the file: ");
      chomp ($input = <>);
      
      unless ($input ~~ /\A\s*\z/)
      {
         eval { @results = grep /$input/, @lines; };
         
         unless ($@)
         {
            my $resultNum = @results;
            
            if ($resultNum)
            {
               print ("The string \"$input\" was found $resultNum times in the following contexts:\n", @results);
            }
            else
            {
               print ("The entered pattern was not found.  Try again!\n");
            }
         }
         else
         {
            print ("Invalid regular expression entered.  Try again!\n");
         }
      }
   } while ($input !~ /\A\s*\z/)
}

