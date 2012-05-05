#! perl-w

use 5.014;
use autodie;
use strict;

opendir (my $DH, ".");

foreach (grep (/.pl/, readdir ($DH)))
{
   print scalar reverse $_;
}