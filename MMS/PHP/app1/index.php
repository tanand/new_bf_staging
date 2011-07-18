<?php
    include ("config.php");
?>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>Receive MMS</title>
</head>

<body>
<img src="http://developer.att.com/developer/images/att.gif" />
<b>Receive MMS Messages</b><br/>
<table>
<tr><th>Sl.No.</th><th>Receive MMS Report</th></tr>
<?php
//get the files within the attachment folder,and display its link.
    $i=0;
    $handle = opendir($attachment_dir.'/');
    while (false !== ($file = readdir($handle))) {
        echo '<tr><td>'.++$i.'</td><td><a href="'.$file.'"/></td></tr>';
    }
?>
</table>
</body>
</html>
