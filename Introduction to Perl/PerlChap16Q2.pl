#! perl -w

use 5.014;
use autodie;
use strict;

# Launched processes inherit the STDOUT, STDERR, and STDIN of the (grand)parent process.
open (STDOUT, ">", "lsout.txt");
open (STDERR, ">", "lserr.txt");

chdir "D:\\";
system ("dir", "/w");