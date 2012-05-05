#! perl -w

use 5.014;
use autodie;
use strict;

if (@ARGV == 2)
{
   my $result = 0;

   my $firstWord = lc shift @ARGV;
   my $secondWord = lc shift @ARGV;

   if (length ($firstWord) == length ($secondWord))
   {
      my @firstWordLetters = split (//, $firstWord);
      my @secondWordLetters = split (//, $secondWord);
    
      @firstWordLetters = sort (@firstWordLetters);
      @secondWordLetters = sort (@secondWordLetters);
    
      $result = 1;
      while (@firstWordLetters and $result)
      {
         $result = (shift (@firstWordLetters) eq shift (@secondWordLetters));
      }
   }
   
   ($result) ? say "These words are anagrams of one another." : say "No relationship.";
}

