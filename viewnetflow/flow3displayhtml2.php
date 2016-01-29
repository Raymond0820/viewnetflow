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
   <td width="110">ip'.orderlink('ip',$urltail).'</td>
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
}
$content.='</table>';





//include('ipnamelist.php');

echo '<table><tr><td valign="top">'.iprangelink($iprangename).'</td><td valign="top">'.$content.'</td></tr></table>';


?>
