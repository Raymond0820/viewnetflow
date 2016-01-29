#!/usr/bin/perl

# $rawdir is where the raw log files kept  

$rawdir    = "/data/flowtool";
$flowexport= "/usr/bin/flow-export";


############

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time-600);
$mon++;
$year+=1900;
$min -= ($min % 10); 
$min += 0;

$mmm = sprintf ("ft-v05.%04d-%02d-%02d.%02d%02d", $year, $mon, $mday, $hour, $min);
$dir = sprintf ("%04d-%02d-%02d", $year, $mon, $mday);

print "$rawdir/$dir/$mmm\n";
opendir DIRREF, "$rawdir/$dir" || die $!;
@flowfiles = grep /^$mmm/, readdir DIRREF;

closedir DIRREF;

############

$user = sprintf("root:raymond0820:localhost:3306:flowtool:f%s%s%s",$year,$mon,$mday);

foreach (@flowfiles) {
  open FLOWDATA, "$flowexport -f3 -mDFLOWS,DPKTS,DOCTETS,SRCADDR,DSTADDR,SRCPORT,DSTPORT,PROT -u $user < $rawdir/$dir/$_ |" || die $!;
}


#########################################

use DBI;
my $dbh = DBI->connect("dbi:mysql:dbname=flowtool", "root", "raymond0820") or die $DBI::errstr;

#########################################

my $sql = "SELECT `dstaddr`,count(*) as flow ,sum(`dPkts`) , sum(`dOctets`) FROM `f$year$mon$mday` where `dstaddr` like '10.%' or `dstaddr` like '172.16.%'  group by  `dstaddr`";
my $sth = $dbh->prepare($sql);
$sth->execute;
while (my @result = $sth->fetchrow_array) {
    $sqlinsert_down.="('$result[0]',$result[1],$result[2],$result[3],0,0,0),";
}
chop($sqlinsert_down);
my $sqlinsert_down="INSERT INTO `today_ipdown` (`ip`,`flow_down`,`dPkts_down`,`dOctets_down`,`flow_up`,`dPkts_up`,`dOctets_up`) VALUES ".$sqlinsert_down.";";

my $sql = "SELECT `srcaddr`,count(*) as flow ,sum(`dPkts`) , sum(`dOctets`)
FROM `f$year$mon$mday` where `srcaddr` like '10.%' or `srcaddr` like '172.16.%' group by  `srcaddr`";
my $sth = $dbh->prepare($sql);
$sth->execute;
while (my @result = $sth->fetchrow_array) {
    $sqlinsert_up.="('$result[0]',0,0,0,$result[1],$result[2],$result[3]),";
}
chop($sqlinsert_up);
my $sqlinsert_up="INSERT INTO `today_ipup` (`ip`,`flow_down`,`dPkts_down`,`dOctets_down`,`flow_up`,`dPkts_up`,`dOctets_up`) VALUES ".$sqlinsert_up.";";

my $sqlclean_down="TRUNCATE TABLE `today_ipdown`";
my $sqlclean_up="TRUNCATE TABLE `today_ipup`";
$dbh->do($sqlclean_down);
$dbh->do($sqlclean_up);
$dbh->do($sqlinsert_down);
$dbh->do($sqlinsert_up);

############################################

my $sql_today_step1="
create table `temp_today_ip` as 
SELECT 
 `ip`,
 sum( `flow_down` ) as `flow_down`,
 sum( `dpkts_down` ) as `dpkts_down`,
 sum(`doctets_down` ) as `doctets_down`,
 sum( `flow_up` ) as `flow_up`,
 sum( `dpkts_up` ) as `dpkts_up`,
 sum( `doctets_up` ) as `doctets_up`
from
(
SELECT *
FROM `today_ipup`
UNION ALL
SELECT *
FROM `today_ipdown`
) as t
GROUP BY `ip`;";

my $sql_today_step2="ALTER TABLE `temp_today_ip` 
CHANGE `flow_down` `flow_down` INT( 10 ),
CHANGE `dpkts_down` `dpkts_down` INT( 10 ),
CHANGE `doctets_down` `doctets_down` INT( 20 ),
CHANGE `flow_up` `flow_up` INT( 10 ),
CHANGE `dpkts_up` `dpkts_up` INT( 10 ),
CHANGE `doctets_up` `doctets_up` INT( 20 );";

my $sql_today_step3="DROP TABLE `today_ip`;";
my $sql_today_step4="RENAME TABLE `flowtool`.`temp_today_ip`  TO `flowtool`.`today_ip` ;";

$dbh->do($sql_today_step1);
$dbh->do($sql_today_step2);
$dbh->do($sql_today_step3);
$dbh->do($sql_today_step4);


$dbh->disconnect;



system("date >> /data/netflow/log ; echo $rawdir/$dir/$mmm >> /data/netflow/log ; echo xxx >> /data/netflow/log");

