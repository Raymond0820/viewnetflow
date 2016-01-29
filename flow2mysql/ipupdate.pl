#!/usr/bin/perl


use DBI;
my $dbh = DBI->connect("dbi:mysql:dbname=flowtool", "root", "raymond0820") or die $DBI::errstr;

###############################

my $sql_week_ip_step1="create table temp_week_ip as 
SELECT 
 ip,
 sum( flow_down ) as flow_down,
 sum( dpkts_down ) as dpkts_down,
 sum(doctets_down ) as doctets_down,
 sum( flow_up ) as flow_up,
 sum( dpkts_up ) as dpkts_up,
 sum( doctets_up ) as doctets_up
from
(
SELECT *
FROM today_ip
UNION ALL
SELECT *
FROM week_ip
) as t
GROUP BY ip;";

my $sql_week_ip_step2="ALTER TABLE `temp_week_ip` 
CHANGE `flow_down` `flow_down` BIGINT( 10 ),
CHANGE `dpkts_down` `dpkts_down` BIGINT( 10 ),
CHANGE `doctets_down` `doctets_down` BIGINT( 20 ),
CHANGE `flow_up` `flow_up` BIGINT( 10 ),
CHANGE `dpkts_up` `dpkts_up` BIGINT( 10 ),
CHANGE `doctets_up` `doctets_up` BIGINT( 20 );";

my $sql_week_ip_step3="DROP TABLE `week_ip`;";
my $sql_week_ip_step4="RENAME TABLE `flowtool`.`temp_week_ip`  TO `flowtool`.`week_ip` ;";

$dbh->do($sql_week_ip_step1);
$dbh->do($sql_week_ip_step2);
$dbh->do($sql_week_ip_step3);
$dbh->do($sql_week_ip_step4);

#####################

my $sql_month_ip_step1="create table temp_month_ip as
SELECT
 ip,
 sum( flow_down ) as flow_down,
 sum( dpkts_down ) as dpkts_down,
 sum(doctets_down ) as doctets_down,
 sum( flow_up ) as flow_up,
 sum( dpkts_up ) as dpkts_up,
 sum( doctets_up ) as doctets_up
from
(
SELECT *
FROM today_ip
UNION ALL
SELECT *
FROM month_ip
) as t
GROUP BY ip;";

my $sql_month_ip_step2="ALTER TABLE `temp_month_ip`
CHANGE `flow_down` `flow_down` BIGINT( 10 ),
CHANGE `dpkts_down` `dpkts_down` BIGINT( 10 ),
CHANGE `doctets_down` `doctets_down` BIGINT( 20 ),
CHANGE `flow_up` `flow_up` BIGINT( 10 ),
CHANGE `dpkts_up` `dpkts_up` BIGINT( 10 ),
CHANGE `doctets_up` `doctets_up` BIGINT( 20 );";

my $sql_month_ip_step3="DROP TABLE `month_ip`;";
my $sql_month_ip_step4="RENAME TABLE `flowtool`.`temp_month_ip`  TO `flowtool`.`month_ip` ;";

$dbh->do($sql_month_ip_step1);
$dbh->do($sql_month_ip_step2);
$dbh->do($sql_month_ip_step3);
$dbh->do($sql_month_ip_step4);

########################record ip statistic summary every day

my $sql='SELECT
 sum( flow_down ) as flow_down,
 sum( dpkts_down ) as dpkts_down,
 sum( doctets_down ) as doctets_down,
 sum( flow_up ) as flow_up,
 sum( dpkts_up ) as dpkts_up,
 sum( doctets_up ) as doctets_up
from `today_ip`
';
my $sth = $dbh->prepare($sql);
$sth->execute;
while (my @result = $sth->fetchrow_array) {
  $sqlinsert="INSERT INTO `history_ip` (`type`,`date`,`flow_down`, `dpkts_down`, `doctets_down`, `flow_up`, `dpkts_up`, `doctets_up`) VALUES ('todayip',now(),$result[0],$result[1],$result[2],$result[3],$result[4],$result[5]);";
}
$dbh->do($sqlinsert);



######################record ip statistic every day
my $sql='SELECT
 ip,flow_down,dpkts_down,doctets_down,flow_up,dpkts_up,doctets_up
from `today_ip`
';
my $sth = $dbh->prepare($sql);
$sth->execute;
while (my @result = $sth->fetchrow_array) {
  $sqlinsert="INSERT INTO `history_today_ip` (`date`,`ip`,`flow_down`, `dpkts_down`, `doctets_down`, `flow_up`, `dpkts_up`, `doctets_up`) VALUES (now(),'$result[0]',$result[1],$result[2],$result[3],$result[4],$result[5],$result[6]);";
$dbh->do($sqlinsert);
}



########################
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time-1000000);
$mon++;
$year+=1900;
$tablename = sprintf ("f%s%s%s", $year, $mon, $mday);
$sql_droptable="drop table `$tablename`";
$dbh->do($sql_droptable);

########################

$dbh->disconnect;

