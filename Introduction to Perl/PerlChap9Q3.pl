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
      chomp;
      s/fred/\n/gi;     #Replace all Freds with a placeholder.
      s/wilma/Fred/gi;  #Replace all Wilmas with Freds.
      s/\n/Wilma/gi;    #Replace all placeholders with Wilmas.
      print $_ . "\n";
   }
}