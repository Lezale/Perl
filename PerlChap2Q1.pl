#!/usr/bin/perl
##  Copyright (C) 2012 Sean Gilliland

while (!$done)
{
   print "Input the circumference of the circle: ";
   chomp ($input = <STDIN>);
   
   print "You input the number: $input\n";
   
   if ($input < 0)
   {
      $input = 0;
   }

   $circumference = 2 * 3.14159 * $input;
   print "Circumference is $circumference\n";
   
   $done = 1;
}