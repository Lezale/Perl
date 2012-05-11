# Author: Sean Gilliland
# Purpose: Parse a Windows Debugging UMDH delta file and present the information in a more easily-digestable format.

#! perl -w

use autodie;
use strict;
use warnings;

my @excludes = qw (  );
my %analysisStatistics = ( 'totalExcluded'   => 0,
                           'totalAnalyzed'   => 0,
                           'totalAllocated'  => 0,
                           'totalDisplayed'  => 0 );

# Purpose:  Compresses the passed table into a display-friendly set of information.
# Parameters:
#    [in/out] $sessionRef - A HASH reference to the session information to be compressed.
# Returns: True if at least one session was successfully compressed, false otherwise.
sub compressSessions
{
   my $sessionRef = shift;
   my %sessions = %{$sessionRef};
   my $retVal = 0;
   my %result;

   while (my ($index, $sessionRef) = each (%sessions))
   {
      my @session = @{$sessionRef};
      my $allocSize = shift @session;
      my $allocNum = shift @session;

      # $allocNum indicates the number of allocations for this stack of this $allocationSize.
      unless (defined ($result {$allocSize}))
      {
         # If there is no record for this allocation size yet, create one and assign an empty list.
         my @empty = ();
         $result {$allocSize} = \@empty;
      }
      
      # Add this allocation number to the list of alloc sessions for this memory allocation size.
      push (@{$result {$allocSize}}, $allocNum);
   }
   
   if (%result)
   {
      %{$sessionRef} = %result;
      $retVal = 1;
   }

   return $retVal;
}

# Purpose: Create a displayable report.  This generates one entry for each allocation size, including number of allocations, number of
#          sub-sessions of this size, and total allocated of this size.
# Parameters:
#    [in/out] $sessionRef - A HASH reference to the compressed session information.
# Returns: 1 if at least one display report was created, false otherwise.
sub createDisplayReport
{
   my $sessionRef = shift;
   my %sessions = %{$sessionRef};
   my %result;
   my $retVal = 0;

   # Now that we have all of the raw information drawn from the UMDH file, process it down further into
   #   something more easily digestable.  We will create a session for each memory allocation size
   #   that will include the size, the total number of allocs for that size, and the total amount of memory
   #   allocated of that size.
   my $index = 0;
   while (my ($allocSize, $allocsArrayRef) = each (%sessions))
   {
      # Pull out the array ref into a first-class array, so the syntax is not so confusing.
      my @allocSession = @{$allocsArrayRef};
      
      my $sessionAllocs = 0;
      foreach my $allocNum (@allocSession)
      {
         $sessionAllocs += $allocNum;
      }

      # Create and populate the session display array.
      #   0 - Size of the allocation.
      #   1 - Number of memory allocations that comprise this memory allocation.
      #   2 - Number of memory allocation sessions of this size.
      #   3 - Total alloc'd of this size.
      my @displaySession;
      push (@displaySession, $allocSize);
      push (@displaySession, $sessionAllocs);
      push (@displaySession, scalar @allocSession);
      push (@displaySession, $allocSize * scalar @allocSession);
      
      # Total memory allocated of this size equals the size of the allocation multiplied by the number of allocations (size of array).
      $analysisStatistics {'totalAllocated'} += $allocSize * @allocSession;
      $result {$index++} = \@displaySession;
   }
   
   if (%result)
   {
      %{$sessionRef} = %result;
      $retVal = 1;
   }
   
   return $retVal;
}

# Purpose:  Display the passed session information.
# Parameters: 
#    [in] $sessionRef - A HASH reference pointing at the session's allocation information.
#    [in] $totalAllocated - The total amount of memory allocated for all sessions.
# Returns:  undef 
sub displayReport
{
   my $sessionRef = shift;
   my $totalAllocated = shift;
   my %sessions = %{$sessionRef};
   
   if (%sessions)
   {
      # Now that we have condensed the information into a set of sessions, display the summary.
      # For now this is sorted by the total amount of memory allocated, which is the third index in the session array.

      # Supply the custom sorting algorithm.
      print ("Size of Allocation   # Allocations   # Sessions   Total Alloc'd   (% of total)\n");
      print ("------------------   -------------   ----------   -------------    ----------\n");

      foreach my $session (reverse sort {@{$sessions {$a}}[3] <=> @{$sessions {$b}}[3]} keys %sessions)
      {
         my ($allocSize, $sessionAllocs, $numSessions, $sessionAllocd) = @{$sessions {$session}};
         my $percent = ($sessionAllocd / $totalAllocated) * 100;
         printf ("    %-18d   %-12d   %-10d   %-13d   %-0.2f%%\n", $allocSize, $sessionAllocs, $numSessions, $sessionAllocd, $percent);
         ++$analysisStatistics {'totalDisplayed'};
      }
   }
   else
   {
      print ("No reports could be derived from file.\n");
   }
}

# Purpose: Displays the statistics associated with this analysis.
# Parameters:
#    [in] $statisticsRef - A HASH reference to the statistics table.
# Returns: undef
sub displayStatistics
{
   my $statisticsRef = shift;
   my %statistics = %{$statisticsRef};

   print ("\n");
   
   if (defined $statistics {'totalAllocated'})
   {
      print ("Total memory allocated: $statistics{'totalAllocated'}\n");
   }

   my $reportSummary = "Report complete.\n";
   if (defined $statistics {'totalAnalyzed'})
   {
      $reportSummary .= "\tAnalyzed $statistics{'totalAnalyzed'} sessions.\n";
   }
   
   if (defined $statistics {'totalDisplayed'})
   {
      $reportSummary .= "\tDisplaying $statistics{'totalDisplayed'} compressed sessions";
      
      if (defined $statistics {'totalExcluded'})
      {
         $reportSummary .= " ($statistics{'totalExcluded'} excluded)";
      }
      
      $reportSummary .= ".\n";
   }
   
   print ("$reportSummary");
}

# Purpose:  Returns true if the passed session information may be included in the final report.
# Parameters:
#    [in] $line - The line to analyze.
# Returns: 1 if the passed line is valid, 0 otherwise.
# Requires:
#    @excludes - The list of terms that are to be excluded from the final report.
sub includeSession
{
   my $line = shift;
   my $retVal = 1;
   
   foreach (@excludes)
   {
      if ($line ~~ /$_/)
      {
         $retVal = 0;
         last;
      }
   }
   
   return $retVal;
}

# Purpose: Read the target file, and generate a list of raw sessions.
# Parameters:
#    [in/out] $sessionRef - A HASH reference pointing to the table in which to place the results.
# Returns: 1 if at least one session was found within the target file, 0 otherwise.
sub readRawSessions
{
   my $sessionRef = shift;

   # Parse the indicated UMDH file, and break out necessary information into a more portable format.
   # First we will parse the file and break it down into allocation sessions.
   my $sessionIndex = 0;
   my %result;
   my $retVal = 0;

   while (<>)
   {
      # Each allocation session begins with a line that matches this regex.
      if (/\A\+\s+(?<allocSize>\d+).*?(?<allocNum>\d+)\s+allocs/)
      {
         # Increment the session index, and create a new session if necessary.
         ++$sessionIndex;
         ++$analysisStatistics {'totalAnalyzed'};

         unless (defined ($result {$sessionIndex}))
         {
            my @sessionInfo;
            push (@sessionInfo, $+{allocSize});
            push (@sessionInfo, $+{allocNum});
            $result {$sessionIndex} = \@sessionInfo;
         }
      }
      
      if (defined ($result {$sessionIndex}))
      {
         unless (&includeSession ($_))
         {
            delete $result {$sessionIndex};
            ++$analysisStatistics {'totalExcluded'};
         }
      }
   }
   
   if (%result)
   {
      %{$sessionRef} = %result;
      $retVal = 1;
   }
   
   return $retVal;
}

my %sessions;

# Read the raw sessions from the target file.
if (&readRawSessions (\%sessions))
{
   # Compress the sessions into a distilled format.
   if (&compressSessions (\%sessions))
   {
      # Generate a report containing all information for each size allocation.
      if (&createDisplayReport (\%sessions))
      {
         # Display the results.
         &displayReport (\%sessions, $analysisStatistics{'totalAllocated'});
         &displayStatistics (\%analysisStatistics);
      }
      else
      {
         warn ("Failed to generate display reports.\n");
      }
   }
   else
   {
      warn ("Failed to compress raw UMDH sessions.\n");
   }
}
else
{
   warn ("Failed to parse target UMDH report.\n");
}