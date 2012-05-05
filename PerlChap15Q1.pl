#! perl -w

use 5.014;
use autodie;
use strict;

my $secretNumber = int (1 + rand 100);

say ("The secret number is: $secretNumber\n");

my $done = 0;
while (!$done)
{
   print ("Enter the secret number: ");
   chomp (my $guessedNumber = <STDIN>);
   given ($guessedNumber)
   {
      when (/(?:quit)|(?:exit)|\A(?:\s*)\z/)    { $done = 1; }
      when (/[^\d+]/)                           { print "Not a number!\n"; }
      when ($_ > $secretNumber)                 { print "Too high!  Try again.\n"; }
      when ($_ < $secretNumber)                 { print "Too low!  Try again.\n"; }
      default                                   { print "You entered the correct number!\n"; $done = 1; }
   }
}