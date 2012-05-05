#! perl -w

use 5.014;
use autodie;
use strict;

foreach (@ARGV)
{
   printf ("%30s", "Analyzing $_:");
   when (-r) { print ("  File is readable."); continue }
   when (-w) { print ("  File is writable.\n"); continue }
   when (-x) { print ("  File is executable.\n"); continue }
}