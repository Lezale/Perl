#! perl -w

use 5.014;
use autodie;
use strict;

$ENV {DEBUG} = 1;

my $debug = $ENV{DEBUG} // 0;
my $secretNumber = int (1 + rand 100);

if ($debug)
{
   print ("The secret number chosen is $secretNumber\n");
}

my $done = 0;
while (!$done)
{
   my $userGuess;

   print ("Enter the secret number: ");
   chomp ($userGuess = <STDIN>);
   
   if ($userGuess =~ /\d+/)
   {
      ($userGuess == $secretNumber) ? print "You entered the correct number!\n" :
      ($userGuess > $secretNumber)  ? print "Too high!  Try again.\n" :
                                      print "Too low!  Try again.\n";

      if ($debug && $userGuess != $secretNumber)
      {
         my $difference = ($userGuess > $secretNumber) ? $userGuess - $secretNumber : $secretNumber - $userGuess;
         print "The guess was $difference points too ", ($userGuess > $secretNumber) ? "high.\n" : "low.\n";
      }
   }
   
   if ($userGuess =~ /(?:quit)|(?:exit)|\A(?:\s*)\z/ || $userGuess == $secretNumber) # Exit conditions - quit, exit, an empty line, or a correct guess.
   {
      $done = 1;
   }
}