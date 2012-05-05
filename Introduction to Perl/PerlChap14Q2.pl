#! perl -w

use 5.014;
use autodie;
use strict;

 my %last_name = qw { fred flintstone Wilma Flintstone Barney Rubble betty rubble Bamm-Bamm Rubble PEBBLES FLINTSTONE };

my @sorted = sort { "\L$last_name{$a}" cmp "\L$last_name{$b}" or "\L$a" cmp "\L$b" } keys %last_name;

foreach (@sorted)
{
   print "$_ $last_name{$_}\n";
}