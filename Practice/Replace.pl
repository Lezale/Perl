#! perl -w

use 5.014;
use strict;
use autodie;

my ($string, $target, $replace) = @ARGV;

my $index = index ($string, $target, -1);

while ($index != -1)
{
   substr ($string, $index, length ($target)) = $replace;

   $index = index ($string, $target, $index + 1);
}

print $string;

print "\n";

$string =~ s/$replace/$target/gi;

print $string;