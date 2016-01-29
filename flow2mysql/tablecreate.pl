#!/usr/bin/perl

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
$mon++;
$year+=1900;


use DBI;
my $dbh = DBI->connect("dbi:mysql:dbname=flowtool", "root", "raymond0820") or die $DBI::errstr;



my $sql = "CREATE TABLE `f$year$mon$mday` (
  `srcaddr` varchar(15) NOT NULL default '',
  `dstaddr` varchar(15) NOT NULL default '',
  `prot` smallint(2) NOT NULL default '0',
  `srcport` smallint(6) NOT NULL default '0',
  `dstport` smallint(6) NOT NULL default '0',
  `dFlows` smallint(10) NOT NULL default '0',
  `dPkts` smallint(10) NOT NULL default '0',
  `dOctets` int(15) NOT NULL default '0'
) TYPE=MyISAM;";
$dbh->do($sql);
$dbh->disconnect;
