#! perl -w

use 5.014;
use autodie;
use strict;

my %word_tracker;

foreach (<>)
{
   chomp ($_);
   $word_tracker {$_}++;
}

my $open_success = open my $LOG, ">", "D:\\StrawberryPerl\\Practice\\Log.txt";

if ($open_success)
{
   say $LOG "I encountered the following words with the indicated frequency:";

   foreach my $key (sort keys (%word_tracker))
   {
      print $LOG ("Encountered $key $word_tracker{$key} time(s)\n");
   }
   
   while ((my $key, my $value) = each (%word_tracker))
   {
      print $LOG ("Encountered $key $value time(s)\n");
   }
   
   close $LOG;
}