#! perl -w

use 5.014;
use autodie;
use strict;

(my $outputFileName = $ARGV[0]) =~ s/\..+/.out/i;
my $openSuccess = open STDOUT, ">", "$outputFileName";

if ($openSuccess)
{
   while (<>)
   {
      s/fred/Larry/gi;
      print;
   }
}