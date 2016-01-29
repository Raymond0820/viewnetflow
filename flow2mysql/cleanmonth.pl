#!/usr/bin/perl


use DBI;
my $dbh = DBI->connect("dbi:mysql:dbname=flowtool", "root", "raymond0820") or die $DBI::errstr;

###################

my $sql='SELECT
 sum( doctets_down ) as doctets_down,
 sum( dpkts_down ) as dpkts_down,
 sum( flow_down ) as flow_down,
 sum( doctets_up ) as doctets_up,
 sum( dpkts_up ) as dpkts_up,
 sum( flow_up ) as flow_up
from `month_ip`';
my $sth = $dbh->prepare($sql);
$sth->execute;
while (my @result = $sth->fetchrow_array) {
  $sqlinsert="INSERT INTO `history_ip` (`type`,`date`,`doctets_down`, `dpkts_down`, `flow_down`, `doctets_up`, `dpkts_up`, `flow_up`) VALUES ('monthip',now(),'$result[0]',$result[1],$result[2],$result[3],$result[4],$result[5]);";
}
$dbh->do($sqlinsert);


###################


my $sql_clean="TRUNCATE TABLE `month_ip`;";

$dbh->do($sql_clean);

###################



$dbh->disconnect;

