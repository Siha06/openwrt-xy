#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf


mv /etc/bw-index.htm /usr/lib/lua/luci/view/admin_status/index.htm

sed -i '/helloworld/d' /etc/opkg/distfeeds.conf
sed -i '/ssrp/d' /etc/opkg/distfeeds.conf
sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -i '/core/d' /etc/opkg/distfeeds.conf



uci set vlmcsd.config.enabled=0
uci commit
/etc/init.d/kms stop
uci del network.wan6
uci del dhcp.lan.dhcpv6
uci del dhcp.lan.ra
uci del network.lan.ip6assign
uci commit network
uci commit
/etc/init.d/network restart

exit 0
