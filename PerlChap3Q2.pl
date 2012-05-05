#! perl -w

@NAMES = qw (fred betty barney dino wilma pebbles bamm-bamm);

print "Input the desired name indices 1-7 (press CTRL-Z to finish input):\n";

chomp (@indices = <STDIN>);

print "You selected: \n";

foreach (@indices)
{
   if ($NAMES [$_ - 1])
   {
      print ($NAMES[$_ - 1]."\n");
   }
}