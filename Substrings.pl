#! perl -w

use 5.014;
use strict;
use autodie;

my ($string, $substring) = @ARGV;

my $index = -1;
for ($index = index ($string, $substring, $index + 1);
     $index  < length ($string) and $index != -1;
     $index = index ($string, $substring, $index + 1))
{
   print ("One index is: $index\n");
}