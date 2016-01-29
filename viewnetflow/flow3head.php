<?

$DBhost='127.0.0.1';
$DBuser='root';
$DBpassword='raymond0820';
$DBname='flowtool';
$link = mysql_connect($DBhost, $DBuser, $DBpassword) or die("Could not connect");
mysql_select_db($DBname) or die("Could not select database");
mysql_query("SET NAMES 'UTF8'");

function orderlink($filed,$urltail){
$orderlink='
<a href="'.$_SERVER['PHP_SELF'].'?filed='.$filed.'&order=desc'.$urltail.'">-</a>
<a href="'.$_SERVER['PHP_SELF'].'?filed='.$filed.'&order=asc'.$urltail.'">+</a>';
return $orderlink;
}

function iprangelink($iprangename){
$link=' <a href="'.$_SERVER['PHP_SELF'].'">ALL</a><br>';
$data=array_keys($iprangename);
while($name=array_pop($data)){
 $iprange='';
 $i=1;
 while($data3=array_pop($iprangename[$name])){
   $iprange.='&iprange'.$i++.'='.$data3;
 }
 $link.=' <a href="'.$_SERVER['PHP_SELF'].'?'.$iprange.'">'.$name.'</a><br>';
}
return $link;
}

Function flowformat($flow) {
                        if ($flow >=1000000000){
                        $showflow[0] = (round($flow/100000000))/10 ;
                        $showflow[1] = GB;
                        }elseif($flow >=1000000){
                        $showflow[0] = (round($flow/100000))/10;
                        $showflow[1] = MB;
                        }elseif($flow >=1000){
                        $showflow[0] = (round($flow/100))/10;
                        $showflow[1] = KB;
                        }else{
                        $showflow[0] = (round($flow*10))/10;
                        $showflow[1] = Byte;
                        }
                         return $showflow[0].$showflow[1];
                        }


include('ipnamelist.php');

///////////////////////////////////////////////

if($_GET['order']=='desc')$order='desc';
if($_GET['order']=='asc')$order='asc';
if($_GET['filed'])$sqlpart1='order by `'.$_GET['filed'].'` '.$order;
if(!$sqlpart1)$sqlpart1='order by `doctets_down` DESC';

if($_GET['iprange1']){
$iprange=$_GET['iprange1'];
//$iprangelink='&iprange1='.$iprange;
//$sqlpart2="where (`ip` like '".$iprange.".%'";
 $iparray=explode('-',$iprange);
 $ipstart=$iparray[0];
 $ipend=$iparray[1];
 $iprangelink='&iprange1='.$ipstart.'-'.$ipend;
 $sqlpart2.="where (INET_ATON(ip)>=INET_ATON('".$ipstart."') and INET_ATON(ip)<=INET_ATON('".$ipend."')) ";
}
for($i=2;$i<16;$i++){
 if($_GET['iprange'.$i]){
 $iprange=$_GET['iprange'.$i];
 //$iprangelink.='&iprange'.$i.'='.$iprange;
 //$sqlpart2.="or `ip` like '".$iprange.".%'";
 $iparray=explode('-',$iprange);
 $ipstart=$iparray[0];
 $ipend=$iparray[1];
 $iprangelink.='&iprange'.$i.'='.$ipstart.'-'.$ipend;
 $sqlpart2.="or (INET_ATON(ip) >= INET_ATON('".$ipstart."') and INET_ATON(ip) <= INET_ATON('".$ipend."') )";
 }
}

if($_GET['state']=='unknownet'){
 $sqlpart2='where 1=1 ';
 $data=array_keys($iprangename);
 while($name=array_pop($data)){
  $iprange='';
  while($data3=array_pop($iprangename[$name])){
   $iprange.='&iprange'.$i++.'='.$data3;
   $iparray=explode('-',$data3);
   $ipstart=$iparray[0];
   $ipend=$iparray[1];
   $sqlpart2.="and (INET_ATON(ip) <= INET_ATON('".$ipstart."') or INET_ATON(ip) >= INET_ATON('".$ipend."') )"; 
  }
 } 
}

//if($_GET['iprange1'])$sqlpart2.=')';
$urltail=$iprangelink;

?>
<a href="flow3todayip.php">flow.today</a>
<a href="flow3weekip.php">flow.week</a>
<a href="flow3monthip.php">flow.month</a>
<a href="flow3history.php">flow.history</a>
<a href="flow3todayip.php?state=unknownet">unknownet</a>

