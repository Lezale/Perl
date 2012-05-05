#! perl -w

use 5.014;
use autodie;
use strict;

my $open_success = open my $LOG, ">", "D:\\StrawberryPerl\\Practice\\Log.txt";

$ENV {DEBUG_LEVEL} = undef;
$ENV {MORE_TEST_STUFF} = undef;

if ($open_success)
{
   my $max_value_len = 0;
   my $max_key_len = 0;
   
   while ((my $key, my $value) = each (%ENV))
   {
      $max_key_len = length ($key) if length ($key) > $max_key_len;
   }

   print $LOG ("Environment variables:\n");
   
   foreach my $key (sort keys %ENV)
   {
      printf $LOG ("%${max_key_len}s %s\n", $key, $ENV{key} // "undefined value");
   }
   
   close $LOG;
}