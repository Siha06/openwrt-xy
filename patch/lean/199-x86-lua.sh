#!/bin/sh

#uci set network.lan.ipaddr=192.168.2.2
#uci set network.lan.gateway=192.168.2.1
#uci set network.lan.dns=192.168.2.1
#uci set dhcp.lan.ignore=1
#uci set network.lan.proto='dhcp'
#uci set luci.main.mediaurlbase=/luci-static/design
#uci commit luci

# 设置默认防火墙规则，方便虚拟机首次访问 WebUI
uci set firewall.@zone[1].input='ACCEPT'
# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

sed -i 's#mirrors.tencent.com/lede#mirrors.pku.edu.cn/immortalwrt#g' /etc/opkg/distfeeds.conf
sed -i '/core/d' /etc/opkg/distfeeds.conf
sed -i '/smpackage/d' /etc/opkg/distfeeds.conf
sed -i '/kwrt/d' /etc/opkg/distfeeds.conf
sed -i '/luci/d' /etc/opkg/distfeeds.conf
sed -i '$a src/gz openwrt_luci https://mirrors.pku.edu.cn/immortalwrt/releases/18.06-k5.4-SNAPSHOT/packages/x86_64/luci' /etc/opkg/distfeeds.conf
sed -i '$a src/gz others https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.1/targets/x86/64/packages' /etc/opkg/customfeeds.conf
date_version=$(date +"%Y.%m.%d")
sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release
echo "DISTRIB_REVISION='V${date_version}'" >> /etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
echo "DISTRIB_DESCRIPTION='OpenWrt  '" >> /etc/openwrt_release

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    mv /etc/my-clash /etc/openclash/core/clash_meta
fi


uci commit
#/etc/init.d/network restart

exit 0
