#1 perl -w

my $ps = 0;

while (<>)
{
    $ps += ($_ =~ s/p//gi)
}

print ($ps);