<?

include('flow3head.php');
$sql="SELECT `ip`,`doctets_down`,`dpkts_down`,`flow_down`,`bpf_down`,`ppf_down`,`bpp_down`,`doctets_up`,`dpkts_up`,`flow_up`,`bpf_up`,`ppf_up`,`bpp_up` FROM `todayip_view` ".$sqlpart2.$sqlpart1;

$sql_sum="SELECT
 sum( doctets_down ) as doctets_down,
 sum( dpkts_down ) as dpkts_down,
 sum( flow_down ) as flow_down,
 sum( bpf_down ) as bpf_down,
 sum( ppf_down ) as ppf_down,
 sum( bpp_down ) as bpp_down,
 sum( doctets_up ) as doctets_up,
 sum( dpkts_up ) as dpkts_up,
 sum( flow_up ) as flow_up,
 sum( bpf_up ) as bpf_up,
 sum( ppf_up ) as ppf_up,
 sum( bpp_up ) as bpp_up
from `todayip_view`
".$sqlpart2;

$sql_avg="SELECT
 avg( doctets_down ) as doctets_down,
 avg( dpkts_down ) as dpkts_down,
 avg( flow_down ) as flow_down,
 avg( bpf_down ) as bpf_down,
 avg( ppf_down ) as ppf_down,
 avg( bpp_down ) as bpp_down,
 avg( doctets_up ) as doctets_up,
 avg( dpkts_up ) as dpkts_up,
 avg( flow_up ) as flow_up,
 avg( bpf_up ) as bpf_up,
 avg( ppf_up ) as ppf_up,
 avg( bpp_up ) as bpp_up
from `todayip_view`
".$sqlpart2;



include('flow3displayview.php');


?>
