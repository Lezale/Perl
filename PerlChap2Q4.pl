#!perl -w

print "Input first number: ";
chomp ($input1 = <STDIN>);

print "Input second number: " ;
chomp ($input2 = <STDIN>);

print $input1 * $input2;