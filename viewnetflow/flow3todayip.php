<?

include('flow3head.php');
$sql="SELECT `ip`,`doctets_down`,`dpkts_down`,`flow_down`,`doctets_up`,`dpkts_up`,`flow_up` FROM `today_ip` ".$sqlpart2.$sqlpart1;

$sql_sum="SELECT
 sum( doctets_down ) as doctets_down,
 sum( dpkts_down ) as dpkts_down,
 sum( flow_down ) as flow_down,
 sum( doctets_up ) as doctets_up,
 sum( dpkts_up ) as dpkts_up,
 sum( flow_up ) as flow_up
from `today_ip`
".$sqlpart2;

$sql_avg="SELECT
 avg( doctets_down ) as doctets_down,
 avg( dpkts_down ) as dpkts_down,
 avg( flow_down ) as flow_down,
 avg( doctets_up ) as doctets_up,
 avg( dpkts_up ) as dpkts_up,
 avg( flow_up ) as flow_up
from `today_ip`
".$sqlpart2;


include('displayhtml.php');


?>
