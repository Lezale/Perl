#! perl -w

use 5.014;
use autodie;
use strict;

foreach (@ARGV)
{
   unlink $_;
}