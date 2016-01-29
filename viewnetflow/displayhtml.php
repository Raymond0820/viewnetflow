<?

$result_sum=mysql_query($sql_sum);
while($data=mysql_fetch_row($result_sum)){
  $sum['downsize']=flowformat($data[0]);
  $sum['downpackets']=$data[1];
  $sum['downflow']=$data[2];
  $sum['upsize']=flowformat($data[3]);
  $sum['uppackets']=$data[4];
  $sum['upflow']=$data[5];
}
$data='';
$result_avg=mysql_query($sql_avg);
while($data=mysql_fetch_row($result_avg)){
  $avg['downsize']=flowformat($data[0]);
  $avg['downpackets']=$data[1];
  $avg['downflow']=$data[2];
  $avg['upsize']=flowformat($data[3]);
  $avg['uppackets']=$data[4];
  $avg['upflow']=$data[5];
}
$data='';

$result=mysql_query($sql);
$content='<table><tr>
   <td width="150">ip'.orderlink('ip',$urltail).'</td>
   <td>down size'.orderlink('doctets_down',$urltail).'</td>
   <td>down packets'.orderlink('dpkts_down',$urltail).'</td>
   <td>down flow'.orderlink('flow_down',$urltail).'</td>
   <td>up size'.orderlink('doctets_up',$urltail).'</td>
   <td>up packets'.orderlink('dpkts_up',$urltail).'</td>
   <td>up flow'.orderlink('flow_up',$urltail).'</td>
 </tr>
 <tr>
   <td>all ip sum</td>
   <td>'.$sum['downsize'].'</td>
   <td>'.$sum['downpackets'].'</td>
   <td>'.$sum['downflow'].'</td>
   <td>'.$sum['upsize'].'</td>
   <td>'.$sum['uppackets'].'</td>
   <td>'.$sum['upflow'].'</td>
 </tr>
 <tr>
   <td>all ip avg</td>
   <td>'.$avg['downsize'].'</td>
   <td>'.$avg['downpackets'].'</td>
   <td>'.$avg['downflow'].'</td>
   <td>'.$avg['upsize'].'</td>
   <td>'.$avg['uppackets'].'</td>
   <td>'.$avg['upflow'].'</td>
 </tr>';
while($data=mysql_fetch_row($result)){
  $content.='<tr>';
  $content.='<td>'.$data[0].'</td><td>'.flowformat($data[1]).'</td><td>'.$data[2].'</td><td>'.$data[3].'</td><td>'.flowformat($data[4]).'</td><td>'.$data[5].'</td><td>'.$data[6].'</td>';
  $content.='</tr>';
  $count++;
  $sql2part.=" `dstaddr` = '".$data[0]."' or ";
}
$content.='</table>';
$content='ip count='.$count.$content;
$content.='<br>'.$sql.'<br>';

if($_GET['state']=='unknownet'){
$content.='<p>who connect to unknown dstip<table><tr>
   <td width="150">srcip</td>
   <td><b>dstip</b></td>
   <td>byte</td>
   <td>flow</td>
   <td>packet</td>
 </tr>';
$sql="SELECT `srcaddr` ,`dstaddr` , sum(doctets)as byte,count( dflows ) AS flow, sum( dpkts ) AS pkt  FROM `f".date('Ynj')."` WHERE ".$sql2part." dstaddr='.$data[0].'  group by srcaddr,dstaddr";
$result=mysql_query($sql);
while($data=mysql_fetch_row($result)){
  //$content.='<tr>';
  //$content.='<td>'.$data[0].'</td><td>'.flowformat($data[1]).'</td><td>'.$data[2].'</td><td>'.$data[3].'</td><td>'.flowformat($data[4]).'</td><td>'.$data[5].'</td><td>'.$data[6].'</td>';
  $content.='<td>'.$data[0].'</td><td><b>'.$data[1].'</b></td><td>'.flowformat($data[2]).'</td><td>'.$data[3].'</td><td>'.$data[4].'</td>';
  $content.='</tr>';
  //$count++;
}
$content.='</table>';
$content.=$sql;
}

//include('ipnamelist.php');

echo '<table><tr><td valign="top" width="200">'.iprangelink($iprangename).'</td><td valign="top">'.$content.'</td></tr></table>';


?>
