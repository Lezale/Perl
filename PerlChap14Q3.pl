#! perl -w

use 5.014;
use autodie;
use strict;

print ("Enter the string to examine: ");
chomp (my $examine = <>);

print ("Enter the string for which to search: ");
chomp (my $search = <>);

print ("Examining \"$examine\" for the substring \"$search\".\n");

my $last_index = -1;
do
{
   $last_index = index ($examine, $search, $last_index + 1);
   
   if ($last_index >= 0)
   {
      print ("Index found: $last_index\n");
   }
} while ($last_index >= 0)