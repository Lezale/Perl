#! perl -w

use 5.014;
use autodie;
use strict;

my $source = undef;
my $target = undef;
my $symLink = undef;

my $parseError = undef;

while (@ARGV and !defined ($parseError))
{
   my $arg = shift @ARGV;
   
   if ($arg =~ /\A-s\z/i) #Handle flags.
   {
      $symLink = 1;
   }
   else #Handle args.
   {
      if (!defined $source)
      {
         $source = $arg;
      }
      elsif (!defined $target)
      {
         $target = $arg;
      }
      else
      {
         $parseError = "Unexpected number of arguments\n";
      }
   }
}

unless (defined ($parseError))
{      
   if (-e $target)
   {
      if (-d $target) # Is a directory?
      {
         $target = "$target\\$source";
      }
   }

   if (defined ($symLink))
   {
      say ("Creating symbolic link");
      symlink $source => $target;
   }
   else
   {
      say ("Creating hard link");
      link $source => $target;
   }   
}
else
{
   die $parseError;
}
