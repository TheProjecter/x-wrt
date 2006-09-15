#!/usr/bin/webif-page
<? 
. /usr/lib/webif/webif.sh
header "Info" "Firmware Info" "@TR<<Firmware Info>>"

?>
<pre><?
_version=$(nvram get firmware_version)
_kversion="$( cat /proc/version )"
_date="$(date)"
_mac="$(/sbin/ifconfig eth0 | grep HWaddr | cut -b39-)"
sed -e 's/&/&amp;/g' < /etc/banner
cat <<EOF
</pre>
<br />
<br />
<table style="width: 90%; text-align: left;" border="0" cellpadding="2" cellspacing="2" align="left">
<tbody>
	<tr>
		<td>@TR<<Firmware Version>></td>
		<td>$_version</td>
	</tr>
	<tr>
		<td>@TR<<Kernel Version>></td>
		<td>$_kversion</td>
	</tr>
	<tr>
		<td>@TR<<Current Date/Time>></td>
		<td>$_date</td>
	</tr>
	<tr>
		<td>@TR<<MAC Address>></td>
		<td>$_mac</td>
	</tr>
</tbody>
</table>
EOF

footer
?>
<!--
##WEBIF:name:Info:2:Frimware Info
-->
