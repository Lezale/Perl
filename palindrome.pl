#! perl -w

use 5.014;
use autodie;
use strict;

while (<>)
{
   chomp;

   $_ = lc $_;
   
   ($_ eq reverse $_) ? say "This is a palindrome." : say "This is NOT a palindrome.";
}