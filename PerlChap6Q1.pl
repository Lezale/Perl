#! perl -w

use 5.014;
use autodie;
use strict;

print "Enter a given name to retrieve the family name: ";

my %family_names =   (
                        'fred' => 'flintstone',
                        'barney' => 'rubble',
                        'wilma' => 'flintstone',
                     );

chomp (my $given_name = <STDIN>);

if (exists $family_names {$given_name})
{
   print "You entered ${given_name}, and the corresponding family name is: $family_names{$given_name}\n";
}
else
{
   say "No corresponding entry.";
}