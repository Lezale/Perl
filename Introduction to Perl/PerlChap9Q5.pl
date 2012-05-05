#! perl -w
##  Copyright (C) 2012 Sean Gilliland

use 5.014;
use autodie;
use strict;

$^I = ".bak";

my %filesToConvert;

foreach (@ARGV)
{
   $filesToConvert {$_} = 1;
}

while (<>)
{
   if (/\A\#\#\s+Copyright\s+\(C\)\s+\d{4}\s+\w+\s+\w+\Z/)
   {
      delete $filesToConvert {$ARGV};
      print STDOUT "Copyright addition unnecessary for file: $ARGV\n";
   }
   
   print; #When $^I is defined while reading from ARGV, all prints will default to the input file.
}

@ARGV = sort keys %filesToConvert;

if (@ARGV > 0) # Reference the list in a scalar context to retrieve the number of indices.
{
   while (<>)
   {
      s/^(\#!.*)$/$1\#\#  Copyright (C) 2012 Sean Gilliland\n/s;
      print;
   }
}