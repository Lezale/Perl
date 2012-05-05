#! perl -w

use 5.014;
use autodie;
use strict;

if (@ARGV >= 2)
{
   my $pattern = shift (@ARGV);
   
   while (<>)
   {
      eval { $_ =~ /$pattern/; };
      
      unless ($@)
      {
         print ("Found in $ARGV: $_\n") if ($_ =~ /$pattern/);
      }
   }
}
else
{
   die ("Invalid number of arguments entered!\n");
}