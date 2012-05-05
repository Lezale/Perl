#! perl -w

use 5.014;
use strict;
use autodie;
use warnings;

use DBI;

my $hostPath = "DBI:mysql:Test";
my $username = "root";
my $password = "Runic024";

my $dbh = DBI->connect ($hostPath, $username, $password) or die ("Could not connect to database.\n");

sub flattenHash
{
	my $targetRef = shift;
	
	if (ref ($targetRef) eq "HASH")
	{
		my %target = %$targetRef;

		foreach (keys %target)
		{
			if (ref ($_) eq 'HASH')
			{
				flattenHash ($_);
			}
			elsif (ref ($target{$_}) eq 'HASH')
			{
				flattenHash ($target{$_});
			}
			else
			{
				print ("$_ => $target{$_}\n");
			}
		}
	}
}

sub flattenList
{
	my $targetRef = shift;
	
	if (ref ($targetRef) eq "ARRAY")
	{
		my @target = @$targetRef;
		foreach (@target)
		{
			if (ref ($_) eq "ARRAY")
			{
				flattenList ($_);
			}
			else
			{
				say;
			}
		}
	}
}

# Create and populate two tables: sale and user
#$dbh->do ("CREATE TABLE sale (sid INT PRIMARY KEY NOT NULL auto_increment, uid INT NOT NULL, description VARCHAR(255), price Decimal(19,4))");
#$dbh->do ("CREATE TABLE user (uid INT PRIMARY KEY NOT NULL auto_increment, name VARCHAR(255) NOT NULL unique)");
#$dbh->do ("INSERT INTO user (name) VALUES('adam'), ('bob'), ('charles'), ('dave'), ('ed')");
#$dbh->do ("INSERT INTO sale (uid, description, price) VALUES(1, 'bat', 5),(1,'ball', 3.5), (1, 'glove', 12.5), (3, 'ball', 3.5), (3, 'bat', 5), (4, 'glove', 7.5)");

# 1. Write a query to output all entries from the sale table.
#my $results = $dbh->selectall_hashref ("SELECT * FROM sale", "sid");
my $results = $dbh->selectall_arrayref ("SELECT * FROM sale");

#&flattenHash ($results);
#&flattenList ($results);

# 2. Write a query to output the username, description, and price of each sale.
my $sth = $dbh->prepare ("SELECT sale.description, sale.price, user.name FROM sale LEFT JOIN user USING (uid)");
$sth->execute ();
$results = $sth->fetchall_arrayref();

#&flattenList ($results);

# 3. Write a query to output the total amount of sales for each user with sales.
my $query = "SELECT user.name, ";
$query   .= "SUM(sale.price) AS \"Total\"";
$query   .= "FROM sale ";
$query   .= "LEFT JOIN user USING (uid) ";
$query   .= "GROUP BY user.uid";

$sth = $dbh->prepare ($query);
$sth->execute ();
$results = $sth->fetchall_arrayref ();

#&flattenList ($results);

# 4. Same as number 3 except this time also list users that do not have any sales.  For these users list their totals as NULL or 0.
$query    = "SELECT user.name, ";
$query   .= "SUM(sale.price) AS \"Total\"";
$query   .= "FROM user ";
$query   .= "LEFT JOIN sale USING (uid) ";
$query   .= "GROUP BY user.uid";

$sth = $dbh->prepare ($query);
$sth->execute ();
$results = $sth->fetchall_arrayref ();

&flattenList ($results);