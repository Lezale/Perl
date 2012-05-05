#! perl -w
##  Copyright (C) 2012 Sean Gilliland

use 5.014;
use autodie;
use strict;

$^I = ".bak";

while (<>)
{
   s/^(\#!.*)$/$1\#\#  Copyright (C) 2012 Sean Gilliland\n/s;
   print;
}
