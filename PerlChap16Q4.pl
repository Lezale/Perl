#! perl -w

use 5.014;
use autodie;
use strict;

my %signals =  (
                  'usr1' => 0,
                  'usr2' => 0,
                  'hup' => 0,
               );

sub usr1Handle
{
   ++$signals {'usr1'};
   print ("Handled the USR1 signal - $signals{'usr1'}\n");
}

sub usr2Handle
{
   ++$signals {'usr2'};
   print ("Handled the USR2 signal - $signals{'usr2'}\n");
}

sub hupHandle
{
   ++$signals {'hup'};
   print ("Handled the HUP signal - $signals{'hup'}\n");
}
               
foreach (keys %signals)
{
   $SIG {uc ($_)} = "${_}handle";
}

while ()
{
   sleep (1);
}