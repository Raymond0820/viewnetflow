<?
$result_sum=mysql_query($sql_sum);
while($data=mysql_fetch_row($result_sum)){
  $sum['downsize']=flowformat($data[0]);
  $sum['downpackets']=$data[1];
  $sum['downflow']=$data[2];
  $sum['downbpf']=$data[3];
  $sum['downppf']=$data[4];
  $sum['downbpp']=$data[5];
  $sum['upsize']=flowformat($data[6]);
  $sum['uppackets']=$data[7];
  $sum['upflow']=$data[8];
  $sum['upbpf']=$data[9];
  $sum['upppf']=$data[10];
  $sum['upbpp']=$data[11];
}
$data='';

$result=mysql_query($sql);
$content='<table><tr>
   <td width="110">ip'.orderlink('ip',$urltail).'</td>
   <td>down size'.orderlink('doctets_down',$urltail).'</td>
   <td>down packets'.orderlink('dpkts_down',$urltail).'</td>
   <td>down flow'.orderlink('flow_down',$urltail).'</td>
   <td>down bpf'.orderlink('bpf_down',$urltail).'</td>
   <td>down ppf'.orderlink('ppf_down',$urltail).'</td>
   <td>down bpp'.orderlink('bpp_down',$urltail).'</td>
   <td>up size'.orderlink('doctets_up',$urltail).'</td>
   <td>up packets'.orderlink('dpkts_up',$urltail).'</td>
   <td>up flow'.orderlink('flow_up',$urltail).'</td>
   <td>up bpf'.orderlink('bpf_up',$urltail).'</td>
   <td>up ppf'.orderlink('ppf_up',$urltail).'</td>
   <td>up bpp'.orderlink('bpp_up',$urltail).'</td>
 </tr>
 <tr>
   <td>all ip</td>
   <td>'.$sum['downsize'].'</td>
   <td>'.$sum['downpackets'].'</td>
   <td>'.$sum['downflow'].'</td>
   <td>'.$sum['downbpf'].'</td>
   <td>'.$sum['downppf'].'</td>
   <td>'.$sum['downbpp'].'</td>
   <td>'.$sum['upsize'].'</td>
   <td>'.$sum['uppackets'].'</td>
   <td>'.$sum['upflow'].'</td>
   <td>'.$sum['upbpf'].'</td>
   <td>'.$sum['upppf'].'</td>
   <td>'.$sum['upbpp'].'</td>
 </tr>';
while($data=mysql_fetch_row($result)){
  $content.='<tr>';
  $content.='
<td>'.$data[0].'</td>
<td>'.flowformat($data[1]).'</td>
<td>'.$data[2].'</td>
<td>'.$data[3].'</td>
<td>'.flowformat($data[4]).'</td>
<td>'.$data[5].'</td>
<td>'.flowformat($data[6]).'</td>
<td>'.flowformat($data[7]).'</td>
<td>'.$data[8].'</td>
<td>'.$data[9].'</td>
<td>'.flowformat($data[10]).'</td>
<td>'.$data[11].'</td>
<td>'.flowformat($data[12]).'</td>
';
  $content.='</tr>';
}
$content.='</table>';






echo '<table><tr><td valign="top">'.iprangelink($iprangename).'</td><td valign="top">'.$content.'</td></tr></table>';


?>
