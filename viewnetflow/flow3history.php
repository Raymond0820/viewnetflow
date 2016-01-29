<?

include('flow3head.php');


$type='todayip';
if($_GET['type']=='todayip'){ $type='todayip'; }
if($_GET['type']=='weekip'){ $type='weekip'; }
if($_GET['type']=='monthip'){ $type='monthip'; }



$sql="SELECT `date`,`doctets_down`,`dpkts_down`,`flow_down`,`doctets_up`,`dpkts_up`,`flow_up`,`type` FROM `history_ip` where type='".$type."' ORDER by date desc";

$result=mysql_query($sql);
$content='<table><tr>
   <td width="200">date</td>
   <td>down size</td>
   <td>down packets</td>
   <td>down flow</td>
   <td>up size</td>
   <td>up packets</td>
   <td>up flow</td>
   <td>type</td>
 </tr>';
while($data=mysql_fetch_row($result)){
  $content.='<tr>';
  $content.='<td>'.$data[0].'</td><td>'.flowformat($data[1]).'</td><td>'.$data[2].'</td><td>'.$data[3].'</td><td>'.flowformat($data[4]).'</td><td>'.$data[5].'</td><td>'.$data[6].'</td><td>'.$data[7].'</td>';
  $content.='</tr>';
}
$content.='</table>';

$content='<p><a href="'.$_SERVER['PHP_SELF'].'?type=todayip">todayip</a> 
<a href="'.$_SERVER['PHP_SELF'].'?type=weekip">weekip</a>
<a href="'.$_SERVER['PHP_SELF'].'?type=monthip">monthip</a>'
.$content;

echo $content;

?>


