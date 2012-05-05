#! perl

print "Input strings (press CTRL-Z to finish input):";

@unchomped_strings = <STDIN>;

chomp (@chomped_strings = @unchomped_strings);

@unchomped_strings = sort (@unchomped_strings);
@chomped_strings = sort (@chomped_strings);

print "One entry per line:\n";
print @unchomped_strings;

print "\n";

print "All on one line: ";
print @chomped_strings;



