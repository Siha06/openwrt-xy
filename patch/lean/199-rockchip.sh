#!/bin/sh

#uci set network.lan.ipaddr=192.168.2.2
#uci set network.lan.gateway=192.168.2.1
#uci set network.lan.dns=192.168.2.1
#uci set dhcp.lan.ignore=1
#uci set network.lan.proto='dhcp'
#uci set luci.main.mediaurlbase=/luci-static/design
#uci commit luci

# 设置主机名映射，解决安卓原生 TV 无法联网的问题
#uci add dhcp domain
#uci set "dhcp.@domain[-1].name=time.android.com"
#uci set "dhcp.@domain[-1].ip=203.107.6.88"
# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

sed -i 's#mirrors.tencent.com/lede#mirrors.pku.edu.cn/immortalwrt#g' /etc/opkg/distfeeds.conf
sed -i '/helloworld/d' /etc/opkg/distfeeds.conf
sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -i '/core/d' /etc/opkg/distfeeds.conf
sed -i '/smpackage/d' /etc/opkg/distfeeds.conf
sed -i '/kwrt/d' /etc/opkg/distfeeds.conf
sed -i '/luci/d' /etc/opkg/distfeeds.conf
sed -i '$a src/gz openwrt_luci https://mirrors.pku.edu.cn/immortalwrt/releases/18.06-k5.4-SNAPSHOT/packages/aarch64_cortex-a53/luci' /etc/opkg/distfeeds.conf
sed -i '$a src/gz others https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.2/targets/rockchip/armv8/packages' /etc/opkg/customfeeds.conf

date_version=$(date +"%Y.%m.%d")
sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release
echo "DISTRIB_REVISION='V${date_version}'" >> /etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
echo "DISTRIB_DESCRIPTION='OpenWrt  '" >> /etc/openwrt_release

cp /etc/my-clash /etc/openclash/core/clash_meta

#/etc/init.d/network restart

exit 0
