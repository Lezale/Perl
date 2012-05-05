#! perl

print "Input strings (press CTRL-Z to finish input):";
#Do not chomp in this case.  We want to preserve the one string per line format.
@strings = <STDIN>;

print reverse @strings;

#Alternatively:

#print reverse <STDIN>;