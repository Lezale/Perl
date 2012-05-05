#! perl -w

use strict;

sub sum
{
   my $total;
   foreach my $value (@_)
   {
      $total += $value;
   }
   
   return $total;
}

print &sum (1, 2, 3). "\n";

my @fred = qw (1 3 5 7 9);
my $fred_total = sum (@fred);

print "The total of \@fred is $fred_total.\n";
print "Enter some numbers on separate lines: " ;
my $user_total = sum (<STDIN>);
print "the total of thsoe numbers is $user_total.\n";