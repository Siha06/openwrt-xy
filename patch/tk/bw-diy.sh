#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf


mv /etc/bw-index.htm /usr/lib/lua/luci/view/admin_status/index.htm

sed -i '/helloworld/d' /etc/opkg/distfeeds.conf
sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -i '/core/d' /etc/opkg/distfeeds.conf

#/etc/init.d/network restart

exit 0
