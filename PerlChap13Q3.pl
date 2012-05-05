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
   my $openSuccess = opendir my ($dh), $userInput;

   if ($openSuccess)
   {
      while (readdir $dh)
      {
         print ("One of the files in this directory is $_\n") if $_ =~ /.* */;
      }
   }
   
   closedir $dh;
}
else
{
   warn "Failed to change directory: $!\n";
}