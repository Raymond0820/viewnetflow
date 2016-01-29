<?

include('flow3head.php');

$sql='SELECT ip, sum( doctets_down ) AS doctets_down, sum( dpkts_down ) AS dpkts_down, sum( flow_down ) AS flow_down, sum( doctets_up ) AS doctets_up, sum( dpkts_up ) AS dpkts_up, sum( flow_up ) AS flow_up
FROM (
SELECT * FROM today_ip
UNION SELECT *
FROM month_ip
) AS t
'.$sqlpart2.' GROUP BY ip '.$sqlpart1;


$sql="SELECT `ip`,
sum(`doctets_down`) as `doctets_down`,
sum(`dpkts_down`)as `dpkts_down`,
sum(`flow_down`) as `flow_down`,
sum(`doctets_up`) as `doctets_up`,
sum(`dpkts_up`) as `dpkts_up`,
sum(`flow_up`) as `flow_up`
FROM
(
SELECT *
FROM today_ip
UNION ALL
SELECT *
FROM month_ip
) as t
".$sqlpart2." group by ip ".$sqlpart1;



$sql_sum="SELECT
 sum( doctets_down ) as doctets_down,
 sum( dpkts_down ) as dpkts_down,
 sum( flow_down ) as flow_down,
 sum( doctets_up ) as doctets_up,
 sum( dpkts_up ) as dpkts_up,
 sum( flow_up ) as flow_up
from
(
SELECT *
FROM today_ip
UNION ALL
SELECT *
FROM month_ip
) as t
".$sqlpart2;

$sql_avg="SELECT
 avg( doctets_down ) as doctets_down,
 avg( dpkts_down ) as dpkts_down,
 avg( flow_down ) as flow_down,
 avg( doctets_up ) as doctets_up,
 avg( dpkts_up ) as dpkts_up,
 avg( flow_up ) as flow_up
from
(
SELECT *
FROM today_ip
UNION ALL
SELECT *
FROM month_ip
) as t
".$sqlpart2;


include('displayhtml.php');


?>
