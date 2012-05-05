#! perl -w

use 5.014;
use autodie;
use strict;

my @array = qw ( reverse This array );

print ("Reversed: ", reverse @array);