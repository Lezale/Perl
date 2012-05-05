#! perl -w

use 5.014;
use autodie;
use strict;

print ("Enter a directory name: ");

if ((chomp (my $userInput = <>)) =~ /\As*\z/)
{
   print ("No input, changing to home directory\n");
   chdir;
}
elsif (-e $userInput)
{
   if (chdir $userInput)
   {
      my @file = glob (".* *");
      
      foreach (sort @file)
      {
         print ("One of the files in this directory is: $_\n");
      }
   }
}
else
{
   warn "Failed to change directory: $!\n";
}