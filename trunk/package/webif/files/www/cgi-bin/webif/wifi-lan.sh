#!/usr/bin/webif-page
<? 
. "/usr/lib/webif/webif.sh"
load_settings network
br_num=$(ifconfig -a|grep br |wc -l |cut -d " " -f 7)
wifi_interface=$(nvram get wl0_ifname)

for interface in $(nvram get lan_ifnames |sed s/$wifi_interface//); do
lan_interfaces_save="$lan_interfaces_save $interface"
done


FORM_dns="${lan_dns:-$(nvram get wifi_dns)}"
LISTVAL="$FORM_dns"
handle_list "$FORM_dnsremove" "$FORM_dnsadd" "$FORM_dnssubmit" 'ip|FORM_dnsadd|@TR<<DNS Address>>|required' && {
	FORM_dns="$LISTVAL"
	save_setting network wifi_dns "$FORM_dns"
}
FORM_dnsadd=${FORM_dnsadd:-192.168.1.1}

if empty "$FORM_submit"; then 
	FORM_wifi_enable="${wifi_enable:-$(nvram get wifi_proto)}"
	case "$FORM_wifi_enable" in
		static)	;;
		*)
			FORM_wifi_enable=none
			;;
	esac

	lan_interfaces_save=$($lan_interfaces_current |sed s/$wifi_interface//)
	
	case "$FORM_wifi_enable" in
		static)
			FORM_wifi_ipaddr=${wifi_ipaddr:-$(nvram get wifi_ipaddr)}
			FORM_wifi_netmask=${wifi_netmask:-$(nvram get wifi_netmask)}
			FORM_wifi_gateway=${wifi_gateway:-$(nvram get wifi_gateway)}
			;;
	esac
else 
	case "$FORM_wifi_enable" in
		static)
SAVED=1
validate <<EOF
ip|FORM_wifi_ipaddr|@TR<<IP Address>>|required|$FORM_wifi_ipaddr
netmask|FORM_wifi_netmask|@TR<<Netmask>>|required|$FORM_wifi_netmask
ip|FORM_wifi_gateway|@TR<<Gateway>>||$FORM_wifi_gateway
EOF
			equal "$?" 0 && {
				save_setting wifi-enable lan_ifnames "$lan_interfaces_save"
				save_setting wifi-enable wifi_ifnames $wifi_interface
				save_setting wifi-enable wifi_ifname br$br_num
				save_setting wifi-enable wifi_stp "1"
				save_setting wifi-enable wifi_proto "static"
				save_setting wifi-enable wifi_ipaddr $FORM_wifi_ipaddr
				save_setting wifi-enable wifi_netmask $FORM_wifi_netmask
				save_setting wifi-enable wifi_gateway $FORM_wifi_gateway
			}
		;;
		*)
			# Do all the nvram varaibles need to be unset?
			save_setting wifi-disable lan_ifnames "$lan_interfaces_save $wifi_interface"
			save_setting wifi-disable wifi_ifnames ""
			save_setting wifi-disable wifi_ifname ""
			save_setting wifi-disable wifi_stp ""
			save_setting wifi-disable wifi_proto ""
			save_setting wifi-disable wifi_ipaddr ""
			save_setting wifi-disable wifi_netmask ""
			save_setting wifi-disable wifi_gateway ""
			save_setting wifi-disable wifi_dns ""
		;;
	esac
fi

header "Network" "WIFI-LAN" "@TR<<WIFI LAN Configuration>>" ' onLoad="modechange()" ' "$SCRIPT_NAME"
cat <<EOF
<script type="text/javascript" src="/webif.js "></script>
<script type="text/javascript">
<!--
function modechange()
{
	set_visible('wifi_config', isset('wifi_enable','static'));
	set_visible('wifi_dns', isset('wifi_enable','static'));
	if (isset('wifi_enable','none'))
	{
            hide('wifi_config');
            hide('wifi_config');
	}
	
	hide('save');
	show('save');
}
-->
</script>
EOF

display_form <<EOF
onchange|modechange
start_form|@TR<<Wireless LAN Enable/Disable>>
field|@TR<<Split Wireless from the switch bridge>>
select|wifi_enable|$FORM_wifi_enable
option|none|@TR<<Disable>>
option|static|@TR<<Enable>>
helpitem|Enable/Disable
helptext|Helptext Enable/Disable#When this is enabled (after you save the settings) it will remove your wireless interface from the bridge with your switch and put it in its own bridge on a seperate subnet.
end_form
start_form|@TR<<Wireless LAN Configuration>>|wifi_config|hidden
field|@TR<<IP Address>>
text|wifi_ipaddr|$FORM_wifi_ipaddr
helpitem|IP Address
helptext|Helptext IP Address#This is the address you want this device to have on your Wireless LAN.
field|@TR<<Netmask>>
text|wifi_netmask|$FORM_wifi_netmask
helpitem|Netmask
helptext|Helptext Netmask#This bitmask indicates what addresses are included in your Wireless LAN. For those who don't know what a bitmask is, just think of "255" as 'match this part' and "0" as 'any number here'.
field|@TR<<Default Gateway>>
text|wifi_gateway|$FORM_wifi_gateway
end_form
start_form|@TR<<DNS Servers>>|wifi_dns|hidden
listedit|dns|$SCRIPT_NAME?|$FORM_dns|$FORM_dnsadd
helpitem|Note
helptext|Helptext DNS save#You need save your settings on this page before adding/removing DNS servers
end_form

EOF

footer ?>
<!--
##WEBIF:name:Network:200:WIFI-LAN
-->
