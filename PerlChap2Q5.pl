#! perl -w

print "Input string: ";
chomp ($string = <STDIN>);

print "Input repetition number: ";
chomp ($reps = <STDIN>);

print "$string\n" x $reps;